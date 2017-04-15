class apt::upgrade {
  include apt::params

  exec { 'apt_upgrade':
    command     => "${apt::params::provider} -y upgrade",
    logoutput   => 'on_failure',
  }
}

