# apt

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with apt](#setup)
    * [What apt affects](#what-apt-affects)
    * [Beginning with apt](#beginning-with-apt)
1. [Usage - Configuration options and additional functionality](#usage)
    * [Add GPG keys](#add-gpg-keys)
    * [Prioritize backports](#prioritize-backports)
    * [Update the list of packages](#update-the-list-of-packages)
    * [Pin a specific release](#pin-a-specific-release) 
    * [Add a Personal Package Archive repository](#add-a-personal-package-archive-repository)
    * [Configure Apt from Hiera](#configure-apt-from-hiera)
    * [Replace the default sources.list file](#replace-the-default-sourceslist-file)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

<a id="module-description"></a>

## Module Description

The apt module lets you use Puppet to manage APT (Advanced Package Tool) sources, keys, and other configuration options.

APT is a package manager available on Debian, Ubuntu, and several other operating systems. The apt module provides a series of classes, defines, types, and facts to help you automate APT package management.

**Note**: Prior to Puppet 7, for this module to correctly autodetect which version of
Debian/Ubuntu (or derivative) you're running, you need to make sure the `lsb-release` package is
installed. With Puppet 7 the `lsb-release` package is not needed.

<a id="setup"></a>

## Setup

<a id="what-apt-affects"></a>

### What apt affects

* Your system's `preferences` file and `preferences.d` directory
* Your system's `sources.list` file and `sources.list.d` directory
* Your system's `apt.conf.d` directory
* System repositories
* Authentication keys

**Note:** This module offers `purge` parameters which, if set to `true`, **destroy** any configuration on the node's `sources.list(.d)`, `preferences(.d)` and `apt.conf.d` that you haven't declared through Puppet. The default for these parameters is `false`.

<a id="beginning-with-apt"></a>

### Beginning with apt

To use the apt module with default parameters, declare the `apt` class.

```puppet
include apt
```

**Note:** The main `apt` class is required by all other classes, types, and defined types in this module. You must declare it whenever you use the module.

<a id="usage"></a>

## Usage

<a id="add-gpg-keys"></a>

### Add GPG keys
You can fetch GPG keys via HTTP, Puppet URI, or local filesystem. The key can be in GPG binary format, or ASCII armored, but the filename should have the appropriate extension (`.gpg` or `.asc`)

#### Fetch via HTTP
```puppet
apt::keyring {'puppetlabs-keyring.gpg':
  source => 'https://apt.puppetlabs.com/keyring.gpg',
}
```

#### Fetch via Puppet URI
```puppet
apt::keyring {'puppetlabs-keyring.gpg':
  source => 'puppet:///modules/my_module/local_puppetlabs-keyring.gpg',
}
```

Alternatively `apt::key` can be used.

**Warning** `apt::key` is deprecated in the latest Debian and Ubuntu releases. Please use apt::keyring instead.

**Warning:** Using short key IDs presents a serious security issue, potentially leaving you open to collision attacks. We recommend you always use full fingerprints to identify your GPG keys. This module allows short keys, but issues a security warning if you use them.

Declare the `apt::key` defined type:

```puppet
apt::key { 'puppetlabs':
  id      => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
  server  => 'pgp.mit.edu',
  options => 'http-proxy="http://proxyuser:proxypass@example.org:3128"',
}
```

<a id="prioritize-backports"></a>

### Prioritize backports

```puppet
class { 'apt::backports':
  pin => 500,
}
```

By default, the `apt::backports` class drops a pin file for backports, pinning it to a priority of 200. This is lower than the normal default of 500, so packages with `ensure => latest` don't get upgraded from backports without your explicit permission.

If you raise the priority through the `pin` parameter to 500, normal policy goes into effect and Apt installs or upgrades to the newest version. This means that if a package is available from backports, it and its dependencies are pulled in from backports unless you explicitly set the `ensure` attribute of the `package` resource to `installed`/`present` or a specific version.

<a id="update-the-list-of-packages"></a>

### Update the list of packages

By default, Puppet runs `apt-get update` on the first Puppet run after you include the `apt` class, and anytime `notify => Exec['apt_update']` occurs; i.e., whenever config files get updated or other relevant changes occur. If you set `update['frequency']` to 'always', the update runs on every Puppet run. You can also set `update['frequency']` to 'daily' or 'weekly':

```puppet
class { 'apt':
  update => {
    frequency => 'daily',
  },
}
```

When `Exec['apt_update']` is triggered, it generates a `notice`-level message. Because the default [logging level for agents](https://puppet.com/docs/puppet/latest/configuration.html#loglevel) is `notice`, this causes the repository update to appear in agent logs. To silence these updates from the default log output, set the [loglevel](https://puppet.com/docs/puppet/latest/metaparameter.html#loglevel) metaparameter for `Exec['apt_update']` above the agent logging level:

```puppet
class { 'apt':
  update => {
    frequency => 'daily',
    loglevel  => 'debug',
  },
}
```

> **NOTE:** Every `Exec['apt_update']` run will generate a corrective change, even if the apt caches are not updated. For example, setting an update frequency of `always` can result in every Puppet run resulting in a corrective change. This is a known issue. For details, see [MODULES-10763](https://tickets.puppetlabs.com/browse/MODULES-10763).

<a id="pin-a-specific-release"></a>

### Pin a specific release

```puppet
apt::pin { 'karmic': priority => 700 }
apt::pin { 'karmic-updates': priority => 700 }
apt::pin { 'karmic-security': priority => 700 }
```

You can also specify more complex pins using distribution properties:

```puppet
apt::pin { 'stable':
  priority        => -10,
  originator      => 'Debian',
  release_version => '3.0',
  component       => 'main',
  label           => 'Debian'
}
```

To pin multiple packages, pass them to the `packages` parameter as an array or a space-delimited string.

<a id="add-a-personal-package-archive-repository"></a>

### Add a Personal Package Archive (PPA) repository

```puppet
apt::ppa { 'ppa:drizzle-developers/ppa': }
```

### Add an Apt source to `/etc/apt/sources.list.d/`

```puppet
apt::source { 'debian_unstable':
  comment  => 'This is the iWeb Debian unstable mirror',
  location => 'http://debian.mirror.iweb.ca/debian/',
  release  => 'unstable',
  repos    => 'main contrib non-free',
  pin      => '-10',
  key      => {
    'id'     => 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553',
    'server' => 'subkeys.pgp.net',
  },
  include  => {
    'src' => true,
    'deb' => true,
  },
}
```

To use the Puppet Apt repository as a source:

```puppet
apt::source { 'puppetlabs':
  location => 'http://apt.puppetlabs.com',
  repos    => 'main',
  key      => {
    'id'     => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
    'server' => 'pgp.mit.edu',
  },
}
```

### Adding name and source to the key parameter of apt::source, which then manages modern apt gpg keyrings

The name parameter of key hash should contain name with extensions (such as puppetlabs.gpg), Absence of extension will result in creation of file with just name and no extension.

```puppet
apt::source { 'puppetlabs':
  comment  => 'Puppet8',
  location => 'https://apt.puppetlabs.com/',
  repos    => 'puppet8',
  key      => {
    'name'   => 'puppetlabs.gpg',
    'source' => 'https://apt.puppetlabs.com/keyring.gpg',
  },
}
```

<a id="configure-apt-from-hiera"></a>

### Configure Apt from Hiera

Instead of specifying your sources directly as resources, you can instead just include the `apt` class, which will pick up the values automatically from hiera.

```yaml
apt::sources:
  'debian_unstable':
    comment: 'This is the iWeb Debian unstable mirror'
    location: 'http://debian.mirror.iweb.ca/debian/'
    release: 'unstable'
    repos: 'main contrib non-free'
    pin: '-10'
    key:
      id: 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553'
      server: 'subkeys.pgp.net'
    include:
      src: true
      deb: true

  'puppetlabs':
    location: 'http://apt.puppetlabs.com'
    repos: 'main'
    key:
      id: '6F6B15509CF8E59E6E469F327F438280EF8D349F'
      server: 'pgp.mit.edu'
```

<a id="replace-the-default-sourceslist-file"></a>

### Replace the default `sources.list` file

The following example replaces the default `/etc/apt/sources.list`. Along with this code, be sure to use the `purge` parameter, or you might get duplicate source warnings when running Apt.

```puppet
apt::source { "archive.ubuntu.com-${facts['os']['distro']['codename']}":
  location => 'http://archive.ubuntu.com/ubuntu',
  key      => '630239CC130E1A7FD81A27B140976EAF437D05B5',
  repos    => 'main universe multiverse restricted',
}

apt::source { "archive.ubuntu.com-${facts['os']['distro']['codename']}-security":
  location => 'http://archive.ubuntu.com/ubuntu',
  key      => '630239CC130E1A7FD81A27B140976EAF437D05B5',
  repos    => 'main universe multiverse restricted',
  release  => "${facts['os']['distro']['codename']}-security"
}

apt::source { "archive.ubuntu.com-${facts['os']['distro']['codename']}-updates":
  location => 'http://archive.ubuntu.com/ubuntu',
  key      => '630239CC130E1A7FD81A27B140976EAF437D05B5',
  repos    => 'main universe multiverse restricted',
  release  => "${facts['os']['distro']['codename']}-updates"
}

apt::source { "archive.ubuntu.com-${facts['os']['distro']['codename']}-backports":
 location => 'http://archive.ubuntu.com/ubuntu',
 key      => '630239CC130E1A7FD81A27B140976EAF437D05B5',
 repos    => 'main universe multiverse restricted',
 release  => "${facts['os']['distro']['codename']}-backports"
}
```

### Manage login configuration settings for an APT source or proxy in `/etc/apt/auth.conf`

Starting with APT version 1.5, you can define login configuration settings, such as
username and password, for APT sources or proxies that require authentication
in the `/etc/apt/auth.conf` file. This is preferable to embedding login
information directly in `source.list` entries, which are usually world-readable.

The `/etc/apt/auth.conf` file follows the format of netrc (used by ftp or
curl) and has restrictive file permissions. See [here](https://manpages.debian.org/testing/apt/apt_auth.conf.5.en.html) for details.

Use the optional `apt::auth_conf_entries` parameter to specify an array of hashes containing login configuration settings. These hashes may only contain the `machine`, `login` and `password` keys.

```puppet
class { 'apt':
  auth_conf_entries => [
    {
      'machine'  => 'apt-proxy.example.net',
      'login'    => 'proxylogin',
      'password' => 'proxypassword',
    },
    {
      'machine'  => 'apt.example.com/ubuntu',
      'login'    => 'reader',
      'password' => 'supersecret',
    },
  ],
}
```

<a id="reference"></a>

## Reference

### Facts

* `apt_updates`: The number of installed packages with available updates from `upgrade`.

* `apt_dist_updates`: The number of installed packages with available updates from `dist-upgrade`.

* `apt_security_updates`: The number of installed packages with available security updates from `upgrade`.

* `apt_security_dist_updates`: The number of installed packages with available security updates from `dist-upgrade`.

* `apt_package_updates`: The names of all installed packages with available updates from `upgrade`. In Facter 2.0 and later this data is formatted as an array; in earlier versions it is a comma-delimited string.

* `apt_package_dist_updates`: The names of all installed packages with available updates from `dist-upgrade`. In Facter 2.0 and later this data is formatted as an array; in earlier versions it is a comma-delimited string.

* `apt_update_last_success`: The date, in epochtime, of the most recent successful `apt-get update` run (based on the mtime of  /var/lib/apt/periodic/update-success-stamp).

* `apt_reboot_required`: Determines if a reboot is necessary after updates have been installed.

### More Information

See [REFERENCE.md](https://github.com/puppetlabs/puppetlabs-apt/blob/main/REFERENCE.md) for all other reference documentation.

<a id="limitations"></a>

## Limitations

This module is not designed to be split across [run stages](https://docs.puppetlabs.com/puppet/latest/reference/lang_run_stages.html).

For an extensive list of supported operating systems, see [metadata.json](https://github.com/puppetlabs/puppetlabs-apt/blob/main/metadata.json)

### Adding new sources or PPAs

If you are adding a new source or PPA and trying to install packages from the new source or PPA on the same Puppet run, your `package` resource should depend on `Class['apt::update']`, as well as depending on the `Apt::Source` or the `Apt::Ppa`. You can also add [collectors](https://docs.puppetlabs.com/puppet/latest/reference/lang_collectors.html) to ensure that all packages happen after `apt::update`, but this can lead to dependency cycles and has implications for [virtual resources](https://docs.puppetlabs.com/puppet/latest/reference/lang_collectors.html#behavior). Before running the command below, ensure that all packages have the provider set to apt.

```puppet
Class['apt::update'] -> Package <| provider == 'apt' |>
```

## Development

Acceptance tests for this module leverage [puppet_litmus](https://github.com/puppetlabs/puppet_litmus).
To run the acceptance tests follow the instructions [here](https://puppetlabs.github.io/litmus/Running-acceptance-tests.html).
You can also find a tutorial and walkthrough of using Litmus and the PDK on [YouTube](https://www.youtube.com/watch?v=FYfR7ZEGHoE).

If you run into an issue with this module, or if you would like to request a feature, please [file a ticket](https://github.com/puppetlabs/puppetlabs-apt/issues).
Every Monday the Puppet IA Content Team has [office hours](https://puppet.com/community/office-hours) in the [Puppet Community Slack](http://slack.puppet.com/), alternating between an EMEA friendly time (1300 UTC) and an Americas friendly time (0900 Pacific, 1700 UTC).

If you have problems getting this module up and running, please [contact Support](http://puppetlabs.com/services/customer-support).

If you submit a change to this module, be sure to regenerate the reference documentation as follows:

```bash
puppet strings generate --format markdown --out REFERENCE.md
```
