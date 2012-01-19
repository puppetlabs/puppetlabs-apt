class apt::update::always inherits apt::update {
  Exec['apt update'] {
    refreshonly => false,
  }
}
