# This Create apt mirror repo sources
#
# == parameters
#
# [*mirror_url*]
#   source repo url
#
# [ release ]
#    Release name, default release is equal to $lsbdistcodename
#
# [ components ]
#    Space separated list of component names
#
# [ include_src ]
#    whther to mirror source packages or not
#
# [ architecture ]
#    which architecture
#
# [ clean ]
#    whther to clean the specifc repo source to free up the space.
#
# == Examples
#
#  ::apt::mirror::source { 'precise':
#    mirror_url => 'http://archive.ubuntu.com/ubuntu',
#    components => 'main restricted universe multiverse',
#    include_src => true,
#    clean => false,
#  }
#
# == Authors
#
# Harish Kumar <hkumarmk@gmail.com>
#
# == Copyright
#
# Copyright 2011 Puppet Labs Inc, unless otherwise noted.

define apt::mirror::source (
  $mirror_url,
  $release           = undef,
  $components        = 'main',
  $include_src       = true,
  $architecture      = undef,
  $clean             = true,
) {

  include apt::params
  if $release {
    $release_real = $release
  } else {
    if $::lsbdistcodename {
      $release_real = $::lsbdistcodename
    } else {
      fail('lsbdistcodename fact not available: release parameter required')
    }
  }
  concat::fragment { "apt-mirror-${name}.conf":
    target  => '/etc/apt/mirror.list',
    order   => '50',
    content => template('apt/mirror.list-source.erb'),
  }
}
