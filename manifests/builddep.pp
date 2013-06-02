# builddep.pp

define apt::builddep() {
  apt::update { "apt-builddep-${title}":}

  exec { "apt-builddep-${name}":
    command   => "/usr/bin/apt-get -y --force-yes build-dep ${name}",
    logoutput => 'on_failure',
    notify    => Apt::Update["apt-builddep-${title}"],
  }
}
