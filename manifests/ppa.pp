# ppa.pp

define apt::ppa(
  $release = $lsbdistcodename
) {

  Class['apt'] -> Apt::Ppa[$title]

  include apt::params

  if ! $release {
    fail('lsbdistcodename fact not available: release parameter required')
  }

  exec { "apt-update-${name}":
    command     => '/usr/bin/aptitude update',
    refreshonly => true,
  }

  $filename_without_slashes = regsubst($name,'/','-','G')
  $filename_without_ppa = regsubst($filename_without_slashes, '^ppa:','','G')
  $sources_list_d_filename = "${filename_without_ppa}-${release}.list"

  exec { "add-apt-repository-${name}":
    command => "/usr/bin/add-apt-repository ${name}",
    notify  => Exec["apt-update-${name}"],
    creates => "${apt::params::sources_list_d}/${sources_list_d_filename}",
  }

  file { "${apt::params::sources_list_d}/${sources_list_d_filename}":
    ensure  => file,
    require => Exec["add-apt-repository-${name}"];
  }

}

