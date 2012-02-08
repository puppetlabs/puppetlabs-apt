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

  $refresh_only_apt_update = $always_apt_update? {
    true => false,
    false => true
  }

  package { "python-software-properties": }

  file { "sources.list":
    path => "${apt::params::root}/sources.list",
    ensure => present,
    owner => root,
    group => root,
    mode => 644,
  }

  file { "sources.list.d":
    path => "${apt::params::root}/sources.list.d",
    ensure => directory,
    owner => root,
    group => root,
  }

  exec { "apt_update":
    command => "${apt::params::provider} update",
    subscribe => [ File["sources.list"], File["sources.list.d"] ],
    refreshonly => $refresh_only_apt_update,
  }
  if($disable_keys) {
    exec { 'make-apt-insecure':
      command => '/bin/echo "APT::Get::AllowUnauthenticated 1;" >> /etc/apt/apt.conf.d/99unauth',
      creates => '/etc/apt/apt.conf.d/99unauth'
    }
  }
}
