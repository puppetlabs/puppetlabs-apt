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
# @param checksum
#   The checksum type to use when determining whether to replace a file's contents.
#
# @param checksum_value
#   The checksum of the source contents. Only md5, sha256, sha224, sha384 and sha512 are supported when specifying this parameter.
#   If this parameter is set, source_permissions will be assumed to be false, and ownership and permissions will not be read from source.
#
define apt::keyring (
  Optional[Stdlib::Absolutepath] $dir = undef,
  String[1] $filename = $name,
  Stdlib::Filemode $mode = '0644',
  Optional[Stdlib::Filesource] $source = undef,
  Optional[String[1]] $content = undef,
  Enum['present','absent'] $ensure = 'present',
  Enum['sha256', 'sha256lite', 'md5', 'md5lite', 'sha1', 'sha1lite', 'sha512', 'sha384', 'sha224', 'mtime', 'ctime', 'none'] $checksum = 'sha256',
  Optional[String[1]] $checksum_value = undef,
) {
  include apt

  # Use the keyrings directory managed by apt class if default is used
  $_dir = pick($dir, "${apt::root}/keyrings")

  if $_dir == "${apt::root}/keyrings" {
    $require_dir = File['keyrings']
  } else {
    ensure_resource('file', $_dir, { ensure => 'directory', mode => '0755', })
    $require_dir = File[$_dir]
  }

  if $source and $content {
    fail("Parameters 'source' and 'content' are mutually exclusive")
  } elsif $ensure == 'present' and ! $source and ! $content {
    fail("One of 'source' or 'content' parameters are required")
  }

  $file = "${_dir}/${filename}"

  case $ensure {
    'present': {
      file { $file:
        ensure         => 'file',
        mode           => $mode,
        owner          => 'root',
        group          => 'root',
        source         => $source,
        content        => $content,
        checksum       => $checksum,
        checksum_value => $checksum_value,
        require        => $require_dir,
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
