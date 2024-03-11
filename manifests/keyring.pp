# @summary Manage GPG keyrings for apt repositories
#
# @example Download the puppetlabs apt keyring
#   apt::keyring { 'puppetlabs-keyring.gpg':
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
# @param dir
#   Path to the directory where the keyring will be stored.
#
# @param filename
#   Optional filename for the keyring. It should also contain extension along with the filename.
#
# @param mode
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
# @param dearmor
#   If the downloaded source should be de-armored. Helpful for e.g. PackageCloud keys.
define apt::keyring (
  Stdlib::Absolutepath $dir = '/etc/apt/keyrings',
  String[1] $filename = $name,
  Stdlib::Filemode $mode = '0644',
  Optional[Stdlib::Filesource] $source = undef,
  Optional[String[1]] $content = undef,
  Enum['present','absent'] $ensure = 'present',
  Boolean $dearmor = false,
) {
  ensure_resource('file', $dir, { ensure => 'directory', mode => '0755', })
  if $source and $content {
    fail("Parameters 'source' and 'content' are mutually exclusive")
  } elsif ! $source and ! $content {
    fail("One of 'source' or 'content' parameters are required")
  }

  $file = "${dir}/${filename}"

  case $ensure {
    'present': {
      file { $file:
        ensure  => 'file',
        mode    => $mode,
        owner   => 'root',
        group   => 'root',
        source  => $source,
        content => $content,
      }

      if $dearmor {
        exec { "dearmor-${name}":
          command     => "gpg --dearmor ${file} && mv ${file}.gpg ${file}",
          refreshonly => true,
          subscribe   => File[$file],
          path        => $facts['path'],
        }
      }
    }
    'absent': {
      file { $file:
        ensure => $ensure,
      }
    }
    default: {
      fail("Invalid 'ensure' value '${ensure}' for apt::keyring")
    }
  }
}
