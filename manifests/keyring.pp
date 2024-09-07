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
# @example Deploy the apt source and associated keyring file with checksum
#   apt::source { 'puppet8-release':
#     location => 'http://apt.puppetlabs.com',
#     repos    => 'puppet8',
#     key      => {
#       name           => 'puppetlabs-keyring.gpg',
#       source         => 'https://apt.puppetlabs.com/keyring.gpg'
#       checksum       => 'sha256',
#       checksum_value => '9d7a61ab06b18454e9373edec4fc7c87f9a91bacfc891893ba0da37a33069771',
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
# @param checksum
#  Checksum type of the keyfile.
#  Only md5, sha256, sha224, sha384 and sha512 are supported when specifying 
#  this parameter. (due to checksum_value parameter).
#  Optional, but is useful if the keyfile is from a remote HTTP source that
#  does not provide the necessary headers for the file resource to determine if
#  content has changed.
#
# @param checksum_value
#  The value of the checksum, must be a String.
#  Only md5, sha256, sha224, sha384 and sha512 are supported when specifying
#  this parameter.
#
define apt::keyring (
  Stdlib::Absolutepath $dir                                           = '/etc/apt/keyrings',
  String[1] $filename                                                 = $name,
  Stdlib::Filemode $mode                                              = '0644',
  Optional[Stdlib::Filesource] $source                                = undef,
  Optional[String[1]] $content                                        = undef,
  Enum['present','absent'] $ensure                                    = 'present',
  Optional[Enum['md5','sha256','sha224','sha384','sha512']] $checksum = undef,
  Optional[String] $checksum_value                                    = undef,
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
        ensure          => 'file',
        mode            => $mode,
        owner           => 'root',
        group           => 'root',
        source          => $source,
        content         => $content,
        checksum        => $checksum,
        checksum_value  => $checksum_value,
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
