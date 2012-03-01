# Apt module for Puppet

## Description
Provides helpful definitions for dealing with Apt.

## Usage

### apt:builddep
Install the build depends of a specified package.
<pre>
apt::builddep { "glusterfs-server": }
</pre>

### apt::force
Force a package to be installed from a specific release.  Useful when using repositories like Debian unstable in Ubuntu.
<pre>
apt::force { "glusterfs-server":
	release => "unstable",
	version => '3.0.3',
	require => Apt::Source["debian_unstable"],
}
</pre>

### apt::pin
Add an apt pin for a certain release.
<pre>
apt::pin { "karmic": priority => 700 }
apt::pin { "karmic-updates": priority => 700 }
apt::pin { "karmic-security": priority => 700 }
</pre>

### apt::ppa
Add a ppa repository using `add-apt-repository`.  Somewhat experimental.
<pre>
apt::ppa { "ppa:drizzle-developers/ppa": }
</pre>

### apt::release
Set the default apt release.  Useful when using repositories like Debian unstable in Ubuntu.
<pre>
apt::release { "karmic": }
</pre>

### apt::source
Add an apt source to `/etc/apt/sources.list.d/`.
<pre>
apt::source { "debian_unstable":
  location          => "http://debian.mirror.iweb.ca/debian/",
  release           => "unstable",
  repos             => "main contrib non-free",
  required_packages => "debian-keyring debian-archive-keyring",
  key               => "55BE302B",
  key_server        => "subkeys.pgp.net",
  pin               => "-10",
  include_src       => true
}
</pre>

### apt::key
Add a key to the list of keys used by apt to authenticate packages.
<pre>
apt::key { "puppetlabs":
  key        => "4BD6EC30",
  key_server => "pgp.mit.edu",
}
</pre>

<pre>
apt::key { "jenkins":
  key        => "D50582E6",
  key_source => "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key",
}
</pre>

Note that use of the "key_source" parameter requires wget to be installed and working.
