class apt::params {
  $root                 = '/etc/apt'
  $provider             = '/usr/bin/apt-get'
  $sources_list_d       = "${root}/sources.list.d"
  $apt_conf_d           = "${root}/apt.conf.d"
  $preferences_d        = "${root}/preferences.d"
  $builddep_refreshonly = false

  case $::lsbdistid {
    'debian': {
      case $::lsbdistcodename {
        'squeeze': {
          $backports_location = 'http://backports.debian.org/debian-backports'
          $legacy_origin       = true
          $origins             = ['${distro_id} oldstable',
                                  '${distro_id} ${distro_codename}-security']
        }
        'wheezy': {
          $backports_location = 'http://ftp.debian.org/debian/'
          $legacy_origin      = false
          $origins            = ['origin=Debian,archive=stable,label=Debian-Security']
        }
        default: {
          $backports_location = 'http://http.debian.net/debian/'
          $legacy_origin      = false
          $origins            = ['origin=Debian,archive=stable,label=Debian-Security']
        }
      }
    }
    'ubuntu': {
      case $::lsbdistcodename {
        'lucid': {
          $backports_location = 'http://us.archive.ubuntu.com/ubuntu'
          $ppa_options        = undef
          $legacy_origin      = true
          $origins            = ['${distro_id} ${distro_codename}-security']
        }
        'precise', 'trusty': {
          $backports_location = 'http://us.archive.ubuntu.com/ubuntu'
          $ppa_options        = '-y'
          $legacy_origin      = true
          $origins            = ['${distro_id}:${distro_codename}-security']
        }
        default: {
          $backports_location = 'http://old-releases.ubuntu.com/ubuntu'
          $ppa_options        = '-y'
          $legacy_origin      = true
          $origins            = ['${distro_id}:${distro_codename}-security']
        }
      }
    }
    default: {
      fail("Unsupported lsbdistid (${::lsbdistid})")
    }
  }
}
