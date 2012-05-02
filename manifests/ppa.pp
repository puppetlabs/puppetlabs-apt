# ppa.pp

define apt::ppa(
  $release = $lsbdistcodename
) {

  Class['apt'] -> Apt::Ppa[$title]

  include apt::params

  $sources_list_d = $apt::params::sources_list_d

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
    creates => "${sources_list_d}/${sources_list_d_filename}",
  }

  file { "${sources_list_d}/${sources_list_d_filename}":
    ensure  => file,
    require => Exec["add-apt-repository-${name}"];
  }
}

