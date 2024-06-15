# @summary Manages the Apt sources in /etc/apt/sources.list.d/.
#
# @example Install the puppetlabs apt source
#   apt::source { 'puppetlabs':
#     location => 'http://apt.puppetlabs.com',
#     repos    => 'main',
#     key      => {
#       id     => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
#       server => 'keyserver.ubuntu.com',
#     },
#   }
#
# @example Download key behaviour to handle modern apt gpg keyrings. The `name` parameter in the key hash should be given with
#   extension. Absence of extension will result in file formation with just name and no extension.
#   apt::source { 'puppetlabs':
#     location => 'http://apt.puppetlabs.com',
#     comment  => 'Puppet8',
#     key      => {
#       'name'   => 'puppetlabs.gpg',
#       'source' => 'https://apt.puppetlabs.com/keyring.gpg',
#     },
#   }
#
# @param location
#   Required, unless ensure is set to 'absent'. Specifies an Apt repository.
#
# @param comment
#   Supplies a comment for adding to the Apt source file.
#
# @param ensure
#   Specifies whether the Apt source file should exist.
#
# @param release
#   Specifies a distribution of the Apt repository.
#
# @param repos
#   Specifies a component of the Apt repository.
#
# @param include
#   Configures include options. Valid options: a hash of available keys.
#
# @option include [Boolean] :deb
#   Specifies whether to request the distribution's compiled binaries.
#
# @option include [Boolean] :src
#   Specifies whether to request the distribution's uncompiled source code.
#
# @param key
#   Creates an `apt::keyring` in `/etc/apt/keyrings` (or anywhere on disk given `filename`) Valid options:
#     * a hash of `parameter => value` pairs to be passed to `file`: `name` (title), `content`, `source`, `filename`
#
#   The following inputs are valid for the (deprecated) `apt::key` defined type. Valid options:
#     * a string to be passed to the `id` parameter of the `apt::key` defined type
#     * a hash of `parameter => value` pairs to be passed to `apt::key`: `id`, `server`, `content`, `source`, `weak_ssl`, `options`
#
# @param keyring
#   Absolute path to a file containing the PGP keyring used to sign this repository. Value is used to set signed-by on the source entry.
#   This is not necessary if the key is installed with `key` param above.
#   See https://wiki.debian.org/DebianRepository/UseThirdParty for details.
#
# @param pin
#   Creates a declaration of the apt::pin defined type. Valid options: a number or string to be passed to the `priority` parameter of the
#   `apt::pin` defined type, or a hash of `parameter => value` pairs to be passed to `apt::pin`'s corresponding parameters.
#
# @param architecture
#   Tells Apt to only download information for specified architectures. Valid options: a string containing one or more architecture names,
#   separated by commas (e.g., 'i386' or 'i386,alpha,powerpc').
#   (if unspecified, Apt downloads information for all architectures defined in the Apt::Architectures option)
#
# @param allow_unsigned
#   Specifies whether to authenticate packages from this release, even if the Release file is not signed or the signature can't be checked.
#
# @param allow_insecure
#   Specifies whether to allow downloads from insecure repositories.
#
# @param notify_update
#   Specifies whether to trigger an `apt-get update` run.
#
# @param check_valid_until
#   Specifies whether to check if the package release date is valid.
#
define apt::source (
  Optional[String[1]] $location = undef,
  String[1] $comment = $name,
  Enum['present', 'absent'] $ensure = present,
  Optional[String[0]] $release = undef,
  String[1] $repos = 'main',
  Hash $include = {},
  Optional[Variant[String[1], Hash]] $key = undef,
  Optional[Stdlib::AbsolutePath] $keyring = undef,
  Optional[Variant[Hash, Integer, String[1]]] $pin = undef,
  Optional[String[1]] $architecture = undef,
  Boolean $allow_unsigned = false,
  Boolean $allow_insecure = false,
  Boolean $notify_update = true,
  Boolean $check_valid_until = true,
) {
  include apt

  $_before = Apt::Setting["list-${title}"]

  if !$release {
    if fact('os.distro.codename') {
      $_release = fact('os.distro.codename')
    } else {
      fail('os.distro.codename fact not available: release parameter required')
    }
  } else {
    $_release = $release
  }

  if $release =~ Pattern[/\/$/] {
    $_components = $_release
  } else {
    $_components = "${_release} ${repos}"
  }

  if $ensure == 'present' {
    if ! $location {
      fail('cannot create a source entry without specifying a location')
    }
    elsif ($apt::proxy['https_acng']) and ($location =~ /(?i:^https:\/\/)/) {
      $_location = regsubst($location, 'https://','http://HTTPS///')
    }
    else {
      $_location = $location
    }
  } else {
    $_location = undef
  }

  $includes = $apt::include_defaults + $include

  if $keyring {
    if $key {
      fail('parameters key and keyring are mutually exclusive')
    } else {
      $_list_keyring = $keyring
    }
  } elsif $key {
    if $key =~ Hash {
      unless $key['name'] or $key['id'] {
        fail('key hash must contain a key name (for apt::keyring) or an id (for apt::key)')
      }
      if $key['id'] {
        # defaults like keyserver are only relevant to apt::key
        $_key = $apt::source_key_defaults + $key
      } else {
        $_key = $key
      }
    } else {
      $_key = { 'id' => assert_type(String[1], $key) }
    }
    if $_key['ensure'] {
      $_key_ensure = $_key['ensure']
    } else {
      $_key_ensure = $ensure
    }

    # Old keyserver keys handled by apt-key
    if $_key =~ Hash and $_key['id'] {
      # We do not want to remove keys when the source is absent.
      if $ensure == 'present' {
        apt::key { "Add key: ${$_key['id']} from Apt::Source ${title}":
          ensure   => $_key_ensure,
          id       => $_key['id'],
          server   => $_key['server'],
          content  => $_key['content'],
          source   => $_key['source'],
          options  => $_key['options'],
          weak_ssl => $_key['weak_ssl'],
          before   => $_before,
        }
      }
      $_list_keyring = undef
    }
    # Modern apt keyrings
    elsif $_key =~ Hash and $_key['name'] {
      apt::keyring { $_key['name']:
        ensure   => $_key_ensure,
        content  => $_key['content'],
        source   => $_key['source'],
        dir      => $_key['dir'],
        filename => $_key['filename'],
        mode     => $_key['mode'],
        before   => $_before,
      }

      $_list_keyring = if $_key['dir'] and $_key['filename'] {
        "${_key['dir']}${_key['filename']}"
      } elsif $_key['filename'] {
        "/etc/apt/keyrings/${_key['filename']}"
      } elsif $_key['dir'] {
        "${_key['dir']}${_key['name']}"
      } else {
        "/etc/apt/keyrings/${_key['name']}"
      }
    }
  } else {
    # No `key` nor `keyring` provided
    $_list_keyring = undef
  }

  $header = epp('apt/_header.epp')

  if $architecture {
    $_architecture = regsubst($architecture, '\baarch64\b', 'arm64')
  } else {
    $_architecture = undef
  }

  $sourcelist = epp('apt/source.list.epp',
    {
      'comment'          => $comment,
      'includes'         => $includes,
      'options'          => delete_undef_values(
        {
          'arch'              => $_architecture,
          'trusted'           => $allow_unsigned ? { true => 'yes', false => undef },
          'allow-insecure'    => $allow_insecure ? { true => 'yes', false => undef },
          'signed-by'         => $_list_keyring,
          'check-valid-until' => $check_valid_until? { true => undef, false => 'false' },
        },
      ),
      'location'         => $_location,
      'components'       => $_components,
    },
  )

  apt::setting { "list-${name}":
    ensure        => $ensure,
    content       => "${header}${sourcelist}",
    notify_update => $notify_update,
  }

  if $pin {
    if $pin =~ Hash {
      $_pin = $pin + { 'ensure' => $ensure, 'before' => $_before }
    } elsif ($pin =~ Numeric or $pin =~ String) {
      $url_split = split($location, '[:\/]+')
      $host      = $url_split[1]
      $_pin = {
        'ensure'   => $ensure,
        'priority' => $pin,
        'before'   => $_before,
        'origin'   => $host,
      }
    } else {
      fail('Received invalid value for pin parameter')
    }

    apt::pin { $name:
      * => $_pin,
    }
  }
}
