class apt::update {
  include apt::params

  exec { 'apt_update':
    command     => "${apt::params::provider} update",
    logoutput   => 'on_failure',
    refreshonly => true,
  }

  Exec['apt_update'] -> Package <| title != "python-software-properties" and title != "software-properties-common" |>
}
