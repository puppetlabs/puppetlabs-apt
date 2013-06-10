class apt::update {
  include apt::params

  exec { 'apt_update':
    command     => "${apt::params::provider} update",
    logoutput   => 'on_failure',
    refreshonly => true,
  }
  
  Exec['apt_update'] -> Package <| title != ["python-software-properties", "software-properties-common"] |>
}
