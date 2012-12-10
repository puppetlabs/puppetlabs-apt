define apt::update {
  include apt::params

  exec { "apt_update ${title}":
    command     => "${apt::params::provider} update",
    logoutput   => 'on_failure',
    refreshonly => true,
  }
}
