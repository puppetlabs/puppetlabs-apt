require 'date'
require 'open-uri'
require 'net/ftp'
require 'tempfile'

if RUBY_VERSION == '1.8.7'
  # Mothers cry, puppies die and Ruby 1.8.7's open-uri needs to be
  # monkeypatched to support passing in :ftp_passive_mode.
  require File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..',
                                    'puppet_x', 'apt_key', 'patch_openuri.rb'))
  OpenURI::Options.merge!({:ftp_active_mode => false,})
end

Puppet::Type.type(:apt_key).provide(:apt_key) do

  KEY_LINE = {
    :date     => '[0-9]{4}-[0-9]{2}-[0-9]{2}',
    :key_type => '(R|D)',
    :key_size => '\d{4}',
    :key_id   => '[0-9a-fA-F]+',
    :expires  => 'expire(d|s)',
  }

  confine    :osfamily => :debian
  defaultfor :osfamily => :debian
  commands   :apt_key  => 'apt-key'

  def self.instances
    cli_args = ['adv','--list-keys', '--with-colons', '--fingerprint']

    if RUBY_VERSION > '1.8.7'
      key_output = apt_key(cli_args).encode('UTF-8', 'binary', :invalid => :replace, :undef => :replace, :replace => '')
    else
      key_output = apt_key(cli_args)
    end

    pub_line, fpr_line = nil

    key_array = key_output.split("\n").collect do |line|
      if line.start_with('pub')?
          pub_line = line
      elsif line.start_with('fpr')?
          fpr_line = line
      end

      next unless not (pub_line and fpr_line)

      line_hash = key_line_hash(pub_line, fpr_line)

      expired = false

      if line_hash[:key_expiry]
        expired = Date.today > Date.parse(line_hash[:key_expiry])
      end

      new(
        :name        => line_hash[:key_id],
        :id          => line_hash[:key_id],
        :fingerprint => line_hash[:key_fingerprint],
        :ensure      => :present,
        :expired     => expired,
        :expiry      => line_hash[:key_expiry],
        :size        => line_hash[:key_size],
        :type        => line_hash[:key_type],
        :created     => line_hash[:key_created]
      )

      # reset everything
      pub_line, fpr_line = nil
    end

    return key_array.compact!
  end

  def self.prefetch(resources)
    apt_keys = instances
    resources.keys.each do |name|
      if name.length == 16
        shortname=name[8..-1]
      else
        shortname=name
      end
      if provider = apt_keys.find{ |key| key.name == shortname }
        resources[name].provider = provider
      end
    end
  end

  def self.key_line_hash(pub_line, fpr_line)
    pub_split = pub_line.split(':')
    fpr_split = fpr_line.split(':')

    return_hash = {
      :key_id          => fpr_split.last[-8..-1], # last 8 characters is id
      :key_size        => pub_split[2],
      :key_type        => nil,
      :key_created     => pub_split[5],
      :key_expiry      => pub_split[6].empty? ? nil : pub_split[6],
      :key_fingerprint => fpr_split.last,
    }

    # set key type based on types defined in /usr/share/doc/gnupg/DETAILS.gz
    case pub_split[3]
    when "1"
      return_hash[:key_type] = :rsa
    when "17"
      return_hash[:key_type] = :dsa
    end

    return return_hash
  end

  def source_to_file(value)
    parsedValue = URI::parse(value)
    if parsedValue.scheme.nil?
      fail("The file #{value} does not exist") unless File.exists?(value)
      value
    else
      begin
        key = parsedValue.read
      rescue OpenURI::HTTPError, Net::FTPPermError => e
        fail("#{e.message} for #{resource[:source]}")
      rescue SocketError
        fail("could not resolve #{resource[:source]}")
      else
        tempfile(key)
      end
    end
  end

  def tempfile(content)
    file = Tempfile.new('apt_key')
    file.write content
    file.close
    file.path
  end

  def exists?
    @property_hash[:ensure] == :present
  end

  def create
    command = []
    if resource[:source].nil? and resource[:content].nil?
      # Breaking up the command like this is needed because it blows up
      # if --recv-keys isn't the last argument.
      command.push('adv', '--keyserver', resource[:server])
      unless resource[:keyserver_options].nil?
        command.push('--keyserver-options', resource[:keyserver_options])
      end
      command.push('--recv-keys', resource[:id])
    elsif resource[:content]
      command.push('add', tempfile(resource[:content]))
    elsif resource[:source]
      command.push('add', source_to_file(resource[:source]))
    # In case we really screwed up, better safe than sorry.
    else
      fail("an unexpected condition occurred while trying to add the key: #{resource[:id]}")
    end
    apt_key(command)
    @property_hash[:ensure] = :present
  end

  def destroy
    #Currently del only removes the first key, we need to recursively list and ensure all with id are absent.
    apt_key('del', resource[:id])
    @property_hash.clear
  end

  def read_only(value)
    fail('This is a read-only property.')
  end

  mk_resource_methods

  # Needed until PUP-1470 is fixed and we can drop support for Puppet versions
  # before that.
  def expired
    @property_hash[:expired]
  end

  # Alias the setters of read-only properties
  # to the read_only function.
  alias :created= :read_only
  alias :expired= :read_only
  alias :expiry=  :read_only
  alias :size=    :read_only
  alias :type=    :read_only
end
