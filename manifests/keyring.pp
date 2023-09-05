# @summary Manage GPG keyrings for apt repositories
#
# @example Install the puppetlabs apt source with keyring.
#     apt::source { 'puppet7-release':
#       location => 'http://apt.puppetlabs.com',
#       repos    => 'main',
#       keyring  => '/etc/apt/keyrings/puppetlabs-keyring.gpg',
#     }
#     apt::keyring {'puppetlabs-keyring.gpg':
#       source => 'https://apt.puppetlabs.com/keyring.gpg',
#     }
#
# @param keyring_dir
#   Path to the directory where the keyring will be stored.
#
# @param keyring_filename
#   Optional filename for the keyring.
#
# @param keyring_file
#   File path of the keyring.
#
# @param keyring_file_mode
#   File permissions of the keyring.
#
# @param source
#   Source of the keyring file. Mutually exclusive with 'content'.
#
# @param content
#   Content of the keyring file. Mutually exclusive with 'source'.
#
# @param ensure
#   Ensure presence or absence of the resource.
#
define apt::keyring (
  Stdlib::Absolutepath $keyring_dir = '/etc/apt/keyrings',
  Optional[String] $keyring_filename = $name,
  Stdlib::Absolutepath $keyring_file = "${keyring_dir}/${keyring_filename}",
  String  $keyring_file_mode = '0644',
  Optional[Stdlib::Filesource] $source = undef,
  Optional[String] $content = undef,
  Enum['present','absent'] $ensure = 'present',
) {
  ensure_resource('file', $keyring_dir, { ensure => 'directory', mode => '0755', })
  if $source and $content {
    fail("Parameters 'source' and 'content' are mutually exclusive")
  }
  case $ensure {
    'present': {
      file { $keyring_file:
        ensure  => 'file',
        mode    => $keyring_file_mode,
        source  => $source,
        content => $content,
      }
    }
    'absent': {
      file { $keyring_file:
        ensure => $ensure,
      }
    }
    default: {
      fail("Invalid 'ensure' value '${ensure}' for apt::keyring")
    }
  }
}
