class apt::update {
  include apt::params

  exec { 'apt update':
    command     => "${apt::params::provider} update",
    refreshonly => true,
  }
}
