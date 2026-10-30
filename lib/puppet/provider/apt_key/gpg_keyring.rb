# frozen_string_literal: true

require 'fileutils'
require 'tmpdir'

# apt 3 (Debian 13, Ubuntu 26.04) no longer ships `apt-key`. This provider is
# used on those systems: keys are de-armored with gpg and stored as individual
# keyring files, which sources reference through `signed-by`.
Puppet::Type.type(:apt_key).provide(:gpg_keyring, parent: :apt_key) do
  desc 'gpg provider for apt_key resource, used when apt-key is not available'

  KEYRING_DIR = '/etc/apt/keyrings'

  confine    'os.family': :debian
  confine    true: Puppet::Util.which('apt-key').nil?
  defaultfor 'os.family': :debian
  commands   gpg: '/usr/bin/gpg'

  def self.keyring_file(id)
    File.join(KEYRING_DIR, "#{id}.gpg")
  end

  def self.instances
    Dir.glob(File.join(KEYRING_DIR, '*.gpg')).sort.flat_map do |file|
      output = gpg('--no-tty', '--show-keys', '--with-colons', '--fingerprint', '--fixed-list-mode', file)
      parse_instances(output.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: ''), keyfile: file)
    end
  end

  def keyring_file
    self.class.keyring_file(resource[:id])
  end

  def create
    FileUtils.mkdir_p(KEYRING_DIR, mode: 0o755)

    if resource[:source].nil? && resource[:content].nil?
      fetch_from_keyserver
    else
      key_file = resource[:content] ? tempfile(resource[:content]) : source_to_file(resource[:source])
      gpg('--no-tty', '--yes', '--dearmor', '--output', keyring_file, key_file.path)
    end

    File.chmod(0o644, keyring_file)
    @property_hash[:ensure] = :present
  end

  def destroy
    FileUtils.rm_f([@property_hash[:keyfile], keyring_file].compact.uniq)
    @property_hash.clear
  end

  private

  def fetch_from_keyserver
    Dir.mktmpdir('apt_key') do |home|
      recv = ['--no-tty', '--homedir', home, '--keyserver', resource[:server]]
      recv.push('--keyserver-options', resource[:options]) unless resource[:options].nil?
      recv.push('--recv-keys', resource[:id])
      gpg(*recv)
      gpg('--no-tty', '--yes', '--homedir', home, '--output', keyring_file, '--export', resource[:id])
    end
  end
end
