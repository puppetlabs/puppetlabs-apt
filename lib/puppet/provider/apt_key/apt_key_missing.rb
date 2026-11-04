# frozen_string_literal: true

# apt 3 (Debian 13, Ubuntu 26.04) no longer ships apt-key. Without this provider
# Puppet fails with the unhelpful "Could not find a suitable provider for apt_key".
# This one is only suitable when apt-key is missing and fails with directions instead.
Puppet::Type.type(:apt_key).provide(:apt_key_missing) do
  desc 'Provider used when the apt-key command is not available. It only reports an error.'

  confine    'os.family': :debian
  confine    true: Puppet::Util.which('apt-key').nil?
  defaultfor 'os.family': :debian

  ERROR_MESSAGE = 'The apt-key command is not available on this system (it was removed in apt 3, e.g. Debian 13 and Ubuntu 26.04), ' \
                  'so apt_key and apt::key cannot be used. Use apt::keyring, or the `key` parameter of apt::source with a `name` and a ' \
                  '`source` or `content` (key => { name => \'example.gpg\', source => \'https://example.com/key.gpg\' }), instead.'

  def exists?
    raise(Puppet::Error, ERROR_MESSAGE)
  end

  def create
    raise(Puppet::Error, ERROR_MESSAGE)
  end

  def destroy
    raise(Puppet::Error, ERROR_MESSAGE)
  end
end
