# recommends.pp

class apt::recommends (
  $install_recommends
) {

  include apt::params

  validate_bool($install_recommends)

  $root = $apt::params::root

  file { "${root}/apt.conf.d/10recommends":
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "APT::Install-Recommends \"${install_recommends}\";"
  }
}
