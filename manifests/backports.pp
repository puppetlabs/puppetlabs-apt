class apt::backports (
  $location = undef,
  $release  = undef,
  $repos    = undef,
  $key      = undef,
  $pin      = 200,
){

  if ($::apt::xfacts['lsbdistid'] == 'debian' or
      $::apt::xfacts['lsbdistid'] == 'ubuntu') {
    $_location = $::apt::backports['location']
    $_release  = "${::apt::xfacts['lsbdistcodename']}-backports"
    $_repos    = $::apt::backports['repos']
    $_key      = $::apt::backports['key']
  } else {
    validate_string($location)
    $_location = $location
    validate_string($release)
    $_release = $release
    validate_string($repos)
    unless is_hash($key) {
      validate_string($key)
    }
    $_key = $key
    unless is_hash($pin) {
      unless (is_numeric($pin) or is_string($pin)) {
        fail('pin must be either a string, number or hash')
      }
    $_pin = $pin
    }
  }

  apt::source { 'backports':
    location => $_location,
    release  => $_release,
    repos    => $_repos,
    key      => $_key,
    pin      => $pin,
  }

}
