# builddep.pp

define apt::builddep (
  $refreshonly = false
) {
  validate_bool($refreshonly)

  include apt::update

  exec { "apt-builddep-${name}":
    command     => "/usr/bin/apt-get -y --force-yes build-dep ${name}",
    logoutput   => 'on_failure',
    notify      => Exec['apt_update'],
    refreshonly => $refreshonly,
  }

  # Need anchor to provide containment for dependencies.
  anchor { "apt::builddep::${name}":
    require => Class['apt::update'],
  }
}
