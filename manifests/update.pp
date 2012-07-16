class apt::update ( $refreshonly = true )  {
  include apt::params

  exec { 'apt_update':
    command     => "${apt::params::provider} update",
    logoutput   => 'on_failure',
    refreshonly => $refreshonly,
  }
}
