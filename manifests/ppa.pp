# ppa.pp

define apt::ppa(
  $release = $lsbdistcodename
) {

  Class['apt'] -> Apt::Ppa[$title]

  include apt::params

  if ! $release {
    fail('lsbdistcodename fact not available: release parameter required')
  }

  $filename_without_slashes = regsubst($name,'/','-','G')
  $filename_without_ppa     = regsubst($filename_without_slashes, '^ppa:','','G')
  $sources_list_d_filename  = "${filename_without_ppa}-${release}.list"
  $sourcelist_path = "${apt::params::sources_list_d}/${sources_list_d_filename}"
  $update_options  = join([
    "-o Dir::Etc::SourceList=${sourcelist_path}",
    '-o Dir::Etc::SourceParts=/dev/null',
    '--no-list-cleanup',
    ], ' ')

  exec { "apt::ppa ${name} apt_update":
    command     => "${apt::params::provider} update ${update_options}",
    refreshonly => true,
  }

  exec { "add-apt-repository-${name}":
    command => "/usr/bin/add-apt-repository ${name}",
    notify  => Exec["apt::ppa ${name} apt_update"],
    creates => "${apt::params::sources_list_d}/${sources_list_d_filename}",
  }

  file { "${apt::params::sources_list_d}/${sources_list_d_filename}":
    ensure  => file,
    require => Exec["add-apt-repository-${name}"];
  }

  file { "${apt::params::sources_list_d}/${sources_list_d_filename}.save":
    ensure  => absent,
    require => Exec["add-apt-repository-${name}"];
  }

}

