# @summary Manages backports.
#
# @example Set up a backport source for Ubuntu
#   include apt::backports
#
# @param location
#   Specifies an Apt repository containing the backports to manage. Valid options: a string containing a URL. Default value for Debian and
#   Ubuntu varies:
#
#   - Debian: 'http://deb.debian.org/debian'
#
#   - Ubuntu: 'http://archive.ubuntu.com/ubuntu'
#
# @param release
#   Specifies a distribution of the Apt repository containing the backports to manage. Used in populating the `sources.list` configuration file.
#   Default: on Debian and Ubuntu, `${fact('os.distro.codename')}-backports`. We recommend keeping this default, except on other operating
#   systems.
#
# @param repos
#   Specifies a component of the Apt repository containing the backports to manage. Used in populating the `sources.list` configuration file.
#   Default value for Debian and Ubuntu varies:
#
#   - Debian: 'main contrib non-free non-free-firmware'
#
#   - Ubuntu: 'main universe multiverse restricted'
#
# @param key
#   Specifies a key to authenticate the backports. Valid options: a string to be passed to the id parameter of the apt::key defined type, or a
#   hash of parameter => value pairs to be passed to apt::key's id, server, content, source, and/or options parameters.
#
# @param keyring
#   Absolute path to a file containing the PGP keyring used to sign this
#   repository. Value is passed to the apt::source and used to set signed-by on
#   the source entry.
#
# @param pin
#   Specifies a pin priority for the backports. Valid options: a number or string to be passed to the `id` parameter of the `apt::pin` defined
#   type, or a hash of `parameter => value` pairs to be passed to `apt::pin`'s corresponding parameters.
#
# @param include
#   Specifies whether to include 'deb' or 'src', or both.
#
class apt::backports (
  Optional[Stdlib::HTTPUrl] $location = undef,
  Optional[String[1]] $release = undef,
  Optional[String[1]] $repos = undef,
  Optional[Variant[String[1], Hash]] $key = undef,
  Stdlib::AbsolutePath $keyring = "/usr/share/keyrings/${facts['os']['name'].downcase}-archive-keyring.gpg",
  Variant[Integer, String[1], Hash] $pin = 200,
  Hash $include = {},
) {
  include apt

  if $location {
    $_location = $location
  }

  if $release {
    $_release = $release
  }

  if $repos {
    $_repos = $repos
  }

  if (!($facts['os']['name'] == 'Debian' or $facts['os']['name'] == 'Ubuntu')) {
    unless $location and $release and $repos {
      fail('If not on Debian or Ubuntu, you must explicitly pass location, release, and repos')
    }
  }

  unless $location {
    $_location = $apt::backports['location']
  }

  unless $release {
    if fact('os.distro.codename') {
      $_release = "${fact('os.distro.codename')}-backports"
    } else {
      fail('os.distro.codename fact not available: release parameter required')
    }
  }

  unless $repos {
    $_repos = $apt::backports['repos']
  }

  $_keyring = if $key {
    undef
  } else {
    $keyring
  }

  if $pin =~ Hash {
    $_pin = $pin
  } elsif $pin =~ Numeric or $pin =~ String {
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
    include  => $include,
    key      => $key,
    keyring  => $_keyring,
    pin      => $_pin,
  }
}
