# builddep.pp

define apt::builddep() {

  Class['apt'] -> Apt::Ppa[$title]

  exec { "apt-update-${name}":
    command     => "/usr/bin/apt-get update",
    refreshonly => true,
  }

  exec { "apt-builddep-${name}":
    command     => "/usr/bin/apt-get -y --force-yes build-dep $name",
    notify  => Exec["apt-update-${name}"],
  }
}
