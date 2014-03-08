# recommends.pp

class apt::recommends (
  $ensure             = present,
  $install_recommends = true,
) {

  include apt::params

  validate_bool($install_recommends)

  $root = $apt::params::root

  file { "${root}/apt.conf.d/10recommends":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "APT::Install-Recommends \"${install_recommends}\";"
  }
}
