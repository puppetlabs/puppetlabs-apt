class apt::backports (
  Optional[Variant[String, Stdlib::Compat::String]] $location = undef,
  Optional[Variant[String, Stdlib::Compat::String]] $release = undef,
  Optional[Variant[String, Stdlib::Compat::String]] $repos = undef,
  Optional[Variant[String, Stdlib::Compat::String, Hash, Stdlib::Compat::Hash]] $key = undef,
  Optional[Variant[Integer, Stdlib::Compat::Integer, String, Stdlib::Compat::String, Hash, Stdlib::Compat::Hash]] $pin  = 200,
){
  if $location {
    validate_legacy(String, 'validate_string', $location)
    $_location = $location
  }
  if $release {
    validate_legacy(String, 'validate_string', $release)
    $_release = $release
  }
  if $repos {
    validate_legacy(String, 'validate_string', $repos)
    $_repos = $repos
  }
  if $key {
    unless is_hash($key) {
      validate_legacy(String, 'validate_string', $key)
    }
    $_key = $key
  }
  if ($facts['lsbdistid'] == 'Debian' or $facts['lsbdistid'] == 'Ubuntu') {
    unless $location {
      $_location = $::apt::backports['location']
    }
    unless $release {
      $_release = "${facts['lsbdistcodename']}-backports"
    }
    unless $repos {
      $_repos = $::apt::backports['repos']
    }
    unless $key {
      $_key =  $::apt::backports['key']
    }
  } else {
    unless $location and $release and $repos and $key {
      fail('If not on Debian or Ubuntu, you must explicitly pass location, release, repos, and key')
    }
  }

  if is_hash($pin) {
    $_pin = $pin
  } elsif is_numeric($pin) or is_string($pin) {
    # apt::source defaults to pinning to origin, but we should pin to release
    # for backports
    $_pin = {
      'priority' => $pin,
      'release'  => $_release,
    }
  } else {
    fail('pin must be either a string, number or hash')
  }

  apt::source { 'backports':
    location => $_location,
    release  => $_release,
    repos    => $_repos,
    key      => $_key,
    pin      => $_pin,
  }
}
