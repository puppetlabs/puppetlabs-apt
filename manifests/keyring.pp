# @summary Manage GPG keyrings for apt repositories
#
# @example Download the puppetlabs apt keyring
#   apt::keyring {'puppetlabs-keyring.gpg':
#     source => 'https://apt.puppetlabs.com/keyring.gpg',
#   }
# @example Deploy the apt source and associated keyring file
#   apt::source { 'puppet8-release':
#     location => 'http://apt.puppetlabs.com',
#     repos    => 'puppet8',
#     key      => {
#       name   => 'puppetlabs-keyring.gpg',
#       source => 'https://apt.puppetlabs.com/keyring.gpg'
#     }
#   }
#
# @param keyring_dir
#   Path to the directory where the keyring will be stored.
#
# @param keyring_filename
#   Optional filename for the keyring. It should also contain extension along with the filename.
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
  } elsif ! $source and ! $content {
    fail("One of 'source' or 'content' parameters are required")
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
