# Class: apt
#
# This module manages the initial configuration of apt.
#
# Parameters:
#   Both of the parameters listed here are not required in general and were
#     added for use cases related to development environments.
#   disable_keys - disables the requirement for all packages to be signed
#   always_apt_update - rather apt should be updated on every run (intended
#     for development environments where package updates are frequent
# Actions:
#
# Requires:
#
# Sample Usage:
#  class { 'apt': }
class apt(
  $disable_keys = false,
  $always_apt_update = false
) {

  include apt::params

  if $always_apt_update == true {
    include apt::update::always
  } else {
    include apt::update
  }

  package { "python-software-properties": }

  file { "sources.list":
    name   => "${apt::params::root}/sources.list",
    ensure => present,
    owner  => root,
    group  => root,
    mode   => 644,
    notify => Exec['apt update'],
  }

  file { "sources.list.d":
    name   => "${apt::params::root}/sources.list.d",
    ensure => directory,
    owner  => root,
    group  => root,
    notify => Exec['apt update'],
  }

  if($disable_keys) {
    exec { 'make-apt-insecure':
      command => '/bin/echo "APT::Get::AllowUnauthenticated 1;" >> /etc/apt/apt.conf.d/99unauth',
      creates => '/etc/apt/apt.conf.d/99unauth'
    }
  }
}
