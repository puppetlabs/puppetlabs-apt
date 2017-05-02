# = Define: apt::dpkg_statoverride
#
# Override ownership and mode of files
#
#
# == Parameters
#
# [*name*]
#   Implicit parameter.
#   File path.
#
# [*user*]
#   User name (or user id if prepended with '#').
#
# [*group*]
#   Group name (or group id if prepended with '#').
#
# [*mode*]
#   File mode, in octal
#
# [*ensure*]
#   Whether to add or delete this configuration
#
#
# == Examples
#
# Usage:
# apt::dpkg_statoverride { '/var/log/puppet':
#   user  => 'puppet',
#   group => 'puppet',
#   mode  => '750',
# }
#
#
define apt::dpkg_statoverride(
  $user,
  $group,
  $mode,
  $ensure = present
) {
  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  case $ensure {
    present: {
      exec { "dpkg_statoverride_${name}-add":
        command => "dpkg-statoverride --update --force --add '${user}' '${group}' '${mode}' '${name}'",
        unless  => "dpkg-statoverride --list '${name}' | grep '${user} ${group} ${mode} ${name}'",
      }
    }
    absent: {
      exec { "dpkg_statoverride_${name}-remove":
        command => "dpkg-statoverride --remove '${name}'",
        onlyif  => "dpkg-statoverride --list '${name}'",
      }
    }
    default: {
      fail("Unknown value for \$ensure: '${ensure}'")
    }
  }
}
