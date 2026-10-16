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
# @example Install the puppetlabs apt source (deb822 format)
#   apt::source { 'puppetlabs':
#     source_format => 'sources'
#     location      => ['http://apt.puppetlabs.com'],
#     repos         => ['puppet8'],
#     keyring       => '/etc/apt/keyrings/puppetlabs.gpg',
#   }
#
# @param source_format
#   The file format to use for the apt source. See https://wiki.debian.org/SourcesList
#
# @param location
#   Required, unless ensure is set to 'absent'. Specifies an Apt repository. Valid options: a string containing a repository URL.
#   DEB822: Supports an array of URL values
#
# @param types
#   DEB822: The package types this source manages.
#
# @param enabled
#   DEB822: Enable or Disable the APT source.
#
# @param comment
#   Supplies a comment for adding to the Apt source file.
#
# @param ensure
#   Specifies whether the Apt source file should exist.
#
# @param release
#   Specifies a distribution of the Apt repository.
#   DEB822: Supports an array of values
#
# @param repos
#   Specifies a component of the Apt repository.
#   DEB822: Supports an array of values
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
#   DEB822: Supports an array of values
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
# @param architecture_add
#   Architectures to add to APT's default or explicitly selected architectures.
# @param architecture_remove
#   Architectures to remove. Must not overlap architecture_add (aarch64 is normalized to arm64).
# @param valid_until_min
#   Minimum validity in seconds from the Release file's creation time (nonnegative).
# @param valid_until_max
#   Maximum validity in seconds from the Release file's creation time (nonnegative).
# @param check_date
#   Whether to check the Release date. Disabling also disables validity checks in APT.
# @param date_max_future
#   Maximum seconds a Release date may be in the future (nonnegative).
# @param by_hash
#   Whether to acquire indexes by hash; force requires repository support.
# @param pdiffs
#   Whether to use incremental index updates.
# @param targets
#   Index target identifiers to download.
# @param targets_add
#   Index target identifiers to add.
# @param targets_remove
#   Index target identifiers to remove.
# @param languages
#   Translation languages to download; use ['none'] to disable translations.
# @param languages_add
#   Translation languages to add.
# @param languages_remove
#   Translation languages to remove.
# @param snapshot
#   Snapshot selector (APT-version-dependent): yes/no, enable/disable, or a UTC timestamp.
#   Requires APT >= 2.7.0 and a repository offering snapshots. Values are passed through:
#   choose the spelling supported by your installed APT version.
# @param allow_weak
#   Whether to permit repositories with weak security information (.list only).
# @param allow_downgrade_to_insecure
#   Whether to permit a previously authenticated repository to become insecure (.list only).
# @param signed_by
#   A keyring path, full fingerprint (optionally ending in !), or a nonempty array of these.
#   Alternatively, an armored public key for deb822 (APT >= 2.4). Exclusive with key and keyring.
#   Multiple keyrings, mixed paths/fingerprints and ! require APT >= 1.8.
#   Uses apt_version; if unavailable, os.family Debian assumes APT 1.6.
#
define apt::source (
  Enum['list', 'sources'] $source_format = 'list',
  Array[Enum['deb','deb-src'], 1, 2] $types = ['deb'],
  Optional[Variant[String[1], Array[String[1]]]] $location = undef,
  String[1] $comment = $name,
  Boolean $enabled = true, # deb822
  Enum['present', 'absent'] $ensure = present,
  Optional[Variant[String[0], Array[String[0]]]] $release = undef,
  Variant[String[1], Array[String[1]]] $repos = 'main',
  Hash $include = {},
  Optional[Variant[String[1], Hash]] $key = undef,
  Optional[Stdlib::AbsolutePath] $keyring = undef,
  Optional[Variant[Hash, Integer, String[1]]] $pin = undef,
  Optional[Variant[String[1], Array[String[1]]]] $architecture = undef,
  Optional[Boolean] $allow_unsigned = undef,
  Optional[Boolean] $allow_insecure = undef,
  Optional[Boolean] $check_valid_until = undef,
  Boolean $notify_update = true,
  Optional[Apt::Source_list] $architecture_add = undef,
  Optional[Apt::Source_list] $architecture_remove = undef,
  Optional[Integer[0]] $valid_until_min = undef,
  Optional[Integer[0]] $valid_until_max = undef,
  Optional[Boolean] $check_date = undef,
  Optional[Integer[0]] $date_max_future = undef,
  Optional[Enum['yes', 'no', 'force']] $by_hash = undef,
  Optional[Boolean] $pdiffs = undef,
  Optional[Apt::Source_list] $targets = undef,
  Optional[Apt::Source_list] $targets_add = undef,
  Optional[Apt::Source_list] $targets_remove = undef,
  Optional[Apt::Source_list] $languages = undef,
  Optional[Apt::Source_list] $languages_add = undef,
  Optional[Apt::Source_list] $languages_remove = undef,
  Optional[Variant[Enum['yes', 'no', 'enable', 'disable'], Pattern[/\A[0-9]{8}T[0-9]{6}Z\z/]]] $snapshot = undef,
  Optional[Boolean] $allow_weak = undef,
  Optional[Boolean] $allow_downgrade_to_insecure = undef,
  Optional[Variant[Apt::Source_signer, Array[Apt::Source_signer, 1], Apt::Source_key]] $signed_by = undef,
) {
  include apt

  $_before = Apt::Setting["list-${title}"]

  if $signed_by != undef and ($key != undef or $keyring != undef) {
    fail('parameters signed_by, key and keyring are mutually exclusive')
  }
  if $signed_by =~ Apt::Source_key and $source_format != 'sources' {
    fail('inline signed_by public keys require deb822 source_format sources')
  }
  if $facts['apt_version'] =~ Pattern[/\A[0-9]+(?:\.[0-9]+)+(?:[+~\-][0-9A-Za-z.+~\-]+)?\z/] {
    $_apt_version = $facts['apt_version']
    $_apt_version_description = "APT ${_apt_version}"
  } elsif fact('os.family') == 'Debian' {
    $_apt_version = '1.6'
    $_apt_version_description = 'APT 1.6 (os.family Debian fallback; apt_version unavailable)'
  } else {
    fail('apt::source cannot determine APT compatibility: apt_version unavailable and os.family is not Debian')
  }

  if $ensure == 'present' {
    if versioncmp($_apt_version, '1.6') < 0 and ($check_date != undef or $date_max_future != undef) {
      fail("check_date and date_max_future require APT >= 1.6; detected ${_apt_version_description}")
    }
    if $snapshot != undef and versioncmp($_apt_version, '2.7.0') < 0 {
      fail("snapshot requires APT >= 2.7.0; detected ${_apt_version_description}")
    }
    if $signed_by =~ Apt::Source_key {
      if versioncmp($_apt_version, '2.4') < 0 {
        fail("inline signed_by public keys require APT >= 2.4; detected ${_apt_version_description}")
      }
    } elsif $signed_by != undef and versioncmp($_apt_version, '1.8') < 0 {
      $_signers = [$signed_by].flatten
      if ($_signers.length > 1 and $_signers.any |$signer| { $signer =~ /^\// }) or $_signers.any |$signer| { $signer =~ /!$/ } {
        fail("signed_by with multiple keyrings, mixed keyrings/fingerprints or ! requires APT >= 1.8; detected ${_apt_version_description}")
      }
    }
    if $source_format == 'sources' and ($allow_weak != undef or $allow_downgrade_to_insecure != undef) {
      fail('allow_weak and allow_downgrade_to_insecure require source_format list; APT ignores these deb822 fields')
    }
  }
  # APT before 1.8 only splits deb822 fingerprint lists on commas.
  $_deb822_signed_by = if $signed_by =~ Array and versioncmp($_apt_version, '1.8') < 0 {
    join($signed_by, ',')
  } else {
    $signed_by
  }
  [$comment, $location, $release, $repos, $architecture, $keyring].flatten.each |$value| {
    if $value =~ String and $value =~ /[\r\n]/ {
      fail('source values must not contain newlines (except an inline signed_by public key)')
    }
    if $architecture != undef {
      assert_type(Apt::Source_list, split(join([$architecture].flatten, ','), ','))
    }
  }

  $_architecture_add = $architecture_add ? {
    undef   => undef,
    default => regsubst($architecture_add, '\baarch64\b', 'arm64'),
  }
  $_architecture_remove = $architecture_remove ? {
    undef   => undef,
    default => regsubst($architecture_remove, '\baarch64\b', 'arm64'),
  }
  if $_architecture_add and $_architecture_remove {
    if $_architecture_add.any |$arch| { $arch in $_architecture_remove } {
      fail('architecture_add and architecture_remove must not overlap')
    }
  }
  if $valid_until_min != undef and $valid_until_max != undef and $valid_until_max != 0 and $valid_until_min > $valid_until_max {
    fail('valid_until_min must not exceed a nonzero valid_until_max')
  }

  # Keep the field spelling paired with its one-line spelling; render only explicitly set values.
  $_advanced_options = delete_undef_values({
    'Architectures-Add'          => $_architecture_add,
    'Architectures-Remove'       => $_architecture_remove,
    'Valid-Until-Min'            => $valid_until_min,
    'Valid-Until-Max'            => $valid_until_max,
    'Check-Date'                 => $check_date,
    'Date-Max-Future'            => $date_max_future,
    'By-Hash'                    => $by_hash,
    'PDiffs'                     => $pdiffs,
    'Targets'                    => $targets,
    'Targets-Add'                => $targets_add,
    'Targets-Remove'             => $targets_remove,
    'Languages'                  => $languages,
    'Languages-Add'              => $languages_add,
    'Languages-Remove'           => $languages_remove,
    'Snapshot'                   => $snapshot,
    'Allow-Weak'                 => $allow_weak,
    'Allow-Downgrade-To-Insecure' => $allow_downgrade_to_insecure,
  })
  $_option_names = {
    'Architectures-Add'    => 'arch+',
    'Architectures-Remove' => 'arch-',
    'Targets-Add'          => 'target+',
    'Targets-Remove'       => 'target-',
    'Targets'             => 'target',
    'Languages-Add'        => 'lang+',
    'Languages-Remove'     => 'lang-',
    'Languages'            => 'lang',
  }
  $_advanced_rendered = $_advanced_options.reduce({}) |$memo, $option| {
    $field = $option[0]
    $value = $option[1]
    $option_name = if $source_format == 'sources' {
      $field
    } else {
      $_option_names[$field] ? { undef => downcase($field), default => $_option_names[$field] }
    }
    $separator = $source_format ? { 'sources' => ' ', default => ',' }
    $rendered = $value ? {
      true    => 'yes',
      false   => 'no',
      default => $value =~ Array ? { true => join($value, $separator), false => String($value) },
    }
    $memo + { $option_name => $rendered }
  }

  case $source_format {
    'list': {
      $_file_suffix = $source_format

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
      } elsif $repos =~ Array {
        $_components = join([$_release] + $repos, ' ')
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
            "${_key['dir']}/${_key['filename']}"
          } elsif $_key['filename'] {
            "/etc/apt/keyrings/${_key['filename']}"
          } elsif $_key['dir'] {
            "${_key['dir']}/${_key['name']}"
          } else {
            "/etc/apt/keyrings/${_key['name']}"
          }
        }
      } else {
        # No `key` nor `keyring` provided
        $_list_keyring = undef
      }
      if $_list_keyring != undef {
        assert_type(Apt::Source_signer, $_list_keyring)
      }

      $header = epp('apt/_header.epp')

      if $architecture {
        $_architecture = join(regsubst([$architecture].flatten, '\baarch64\b', 'arm64'), ',')
      } else {
        $_architecture = undef
      }

      $source_content = epp('apt/source.list.epp', {
          'comment'          => $comment,
          'includes'         => $includes,
          'options'          => delete_undef_values({
              'arch'              => $_architecture,
              'trusted'           => $allow_unsigned ? { true => 'yes', false => undef, default => undef },
              'allow-insecure'    => $allow_insecure ? { true => 'yes', false => undef, default => undef },
              'signed-by'         => $signed_by ? { undef => $_list_keyring, default => join([$signed_by].flatten, ',') },
              'check-valid-until' => $check_valid_until? { true => undef, false => 'false', default => undef },
            },
          ) + $_advanced_rendered,
          'location'         => $_location,
          'components'       => $_components,
        }
      )
      $_content = "${header}${source_content}"

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
    'sources': {
      $_file_suffix = $source_format

      if $pin {
        warning("'pin' parameter is not supported with deb822 format.")
      }
      if $key {
        warning("'key' parameter is not supported with deb822 format.")
      }
      if $ensure == 'present' {
        if ! $location {
          fail('cannot create a source entry without specifying a location')
        }
      }
      if $location !~ Array {
        warning('For deb822 sources, location must be specified as an array.')
        $_location = [$location]
      } else {
        $_location = $location
      }

      if !$release {
        if fact('os.distro.codename') {
          $_release = [fact('os.distro.codename')]
        } else {
          fail('os.distro.codename fact not available: release parameter required')
        }
      } elsif $release !~ Array {
        warning("For deb822 sources, 'release' must be specified as an array. Converting to array.")
        $_release = [$release]
      } else {
        $_release = $release
      }

      # The deb822 format requires that if the Suite ends with a slash (/),
      # the Components field must be omitted. Otherwise, Components is required.
      # Mixing path-style (ending with /) and codename-style suites is invalid.
      $_any_suites_end_with_slash = $_release.any |$item| { $item =~ /\/$/ }
      $_all_suites_end_with_slash = $_release.all |$item| { $item =~ /\/$/ }
      if $_any_suites_end_with_slash and !$_all_suites_end_with_slash {
        fail("apt::source ${name}: Mixing path-style suites (ending with /) and codename-style suites is not valid in deb822 format.")
      }
      if $_all_suites_end_with_slash {
        $_repos = undef
      } elsif $repos !~ Array {
        warning("For deb822 sources, 'repos' must be specified as an array. Converting to array.")
        $_repos = split($repos, /\s+/)
      } else {
        $_repos = $repos
      }

      if $architecture and $architecture !~ Array {
        warning("For deb822 sources, 'architecture' must be specified as an array. Converting to array.")
        $_architecture = split($architecture, '[,]')
      } else {
        $_architecture = $architecture
      }
      case $ensure {
        'present': {
          $header = epp('apt/_header.epp')
          $source_content = epp('apt/source_deb822.epp', delete_undef_values({
                'uris'              => $_location,
                'suites'            => $_release,
                'components'        => $_repos,
                'types'             => $types,
                'comment'           => $comment,
                'enabled'           => $enabled ? { true => 'yes', false => 'no' },
                'architectures'     => $_architecture,
                'allow_insecure'    => $allow_insecure ? { true => 'yes', false => 'no', default => undef },
                'repo_trusted'      => $allow_unsigned ? { true => 'yes', false => 'no', default => undef },
                'check_valid_until' => $check_valid_until ? { true => 'yes', false => 'no', default => undef },
                'signed_by'         => $_deb822_signed_by ? { undef => $keyring, default => $_deb822_signed_by },
                'advanced_options'  => $_advanced_rendered,
              }
            )
          )
          $_content = "${header}${source_content}"
        }
        'absent': {
          $_content = undef
        }
        default: {
          fail('Unexpected value for $ensure parameter.')
        }
      }
    }
    default: {
      fail("Unexpected APT source format: ${source_format}")
    }
  }
  apt::setting { "${_file_suffix}-${name}":
    ensure        => $ensure,
    content       => $_content,
    notify_update => $notify_update,
  }
}
