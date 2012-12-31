apt
====

Module Description
-------------------

APT is a package management system. This module gives you an interface to work with APT, 
including the ability to add and delete sources, along with other management tasks. 

Usage
------

### Classes

**apt**

Install APT

    class { 'apt':
      always_apt_update    => false,
      disable_keys         => undef,
      proxy_host           => false,
      proxy_port           => '8080',
      purge_sources_list   => false,
      purge_sources_list_d => false,
      purge_preferences_d  => false
    }
    
This class should always be included in your manifests if you are using the `apt`
module.

**apt::backports**

To add the necessary components to get backports for Ubuntu and Debian, you can either

	include apt::backports
	
 or
 
	class { 'apt::backports':
     release  => 'natty',
     location => 'x'
   	}

With the above class, you may choose to include only one of the attributes. 

**apt::update**

Get a regularly updated APT source repository list

	file { '/tmp/foo':
     ensure  => file,
     notify  => Class['apt::update']
   	}
	
### Defined Types

**apt::builddep**

Install the build depends of a specified package

    apt::builddep { "glusterfs-server": }

**apt::force**

Force a package to be installed from a specific release

    apt::force { "glusterfs-server":
	  release => "unstable",
	  version => '3.0.3',
	  require => Apt::Source["debian_unstable"],
    }

**apt::key**

Add a key to the list of keys used by APT to authenticate packages

    apt::key { "puppetlabs":
      key        => "4BD6EC30",
      key_server => "pgp.mit.edu",
    }

    apt::key { "jenkins":
      key        => "D50582E6",
      key_source => "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key",
    }

Note that use of the `key_source` parameter requires wget to be installed and working.

**apt::pin**

Add an APT pin for a certain release

    apt::pin { "karmic": priority => 700 }
    apt::pin { "karmic-updates": priority => 700 }
    apt::pin { "karmic-security": priority => 700 }

**apt::ppa**

Add a PPA repository

	$ add-apt-repository

then

    apt::ppa { "ppa:drizzle-developers/ppa": }

This is still somewhat experimental. 

**apt::release**

Set the default APT release

    apt::release { "karmic": }

Useful when using repositories that are unstable in Ubuntu.

**apt::source**

Add an APT source to `/etc/apt/sources.list.d/`

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

This source will configure your system for the Puppet Labs APT repository

    apt::source { 'puppetlabs':
      location   => 'http://apt.puppetlabs.com',
      repos      => 'main',
      key        => '4BD6EC30',
      key_server => 'pgp.mit.edu',
    }

Implementation
---------------

### Directories

>File['${apt_conf_d}/${priority}${name}'

>File['/etc/apt/sources.list']

>File['etc/apt/sources.list.d']

>File['etc/apt/preferences.d']

>File['${apt_conf_d}/99unauth']

>File['${apt_conf_d}/proxy']

>File['${name}.pref']

>File['${sources_list_d}/${sources_list_d_filename}']

>File['${root}/apt.conf.d/01release']

>File['${sources_list_d}/${name}.list']

### Packages

**Package['$::lsbdistrelease']**
	
	$package = $::lsbdistrelease ? {
	  /^[1-9]\..*|1[01]\..*|12.04$/ => 'python-software-properties',
	  default  => 'software-properties-common',
	}

Limitations
------------

There are some known bugs and issues with this module. Please see [our issue tracker] (https://github.com/puppetlabs/puppetlabs-apt/pulls)
to keep up to date.
	
Please log tickets and issues at our [Report issues page] (http://projects.puppetlabs.com/projects/modules)

Development
------------

Puppet Labs modules on the Puppet Forge are open projects, and community contributions
are essential for keeping them great. We can’t access the huge number of platforms and
myriad of hardware, software, and deployment configurations that Puppet is intended to serve.

We want to keep it as easy as possible to contribute changes so that our modules work
in your environment. There are a few guidelines that we need contributors to follow so
that we can have a chance of keeping on top of things.

You can read the complete module contribution guide [on the Puppet Labs wiki.](http://projects.puppetlabs.com/projects/module-site/wiki/Module_contributing) 
	
Disclaimer
-----------



Contributors
-------------

A lot of great people have contributed to this module. A somewhat
current list follows.

Ben Godfrey <ben.godfrey@wonga.com>
Branan Purvine-Riley <branan@puppetlabs.com>
Christian G. Warden <cwarden@xerus.org>  
Dan Bode <bodepd@gmail.com> <dan@puppetlabs.com>  
Garrett Honeycutt <github@garretthoneycutt.com>  
Jeff Wallace <jeff@evolvingweb.ca> <jeff@tjwallace.ca>  
Ken Barber <ken@bob.sh>  
Matthaus Litteken <matthaus@puppetlabs.com> <mlitteken@gmail.com>  
Matthias Pigulla <mp@webfactory.de>  
Monty Taylor <mordred@inaugust.com>  
Peter Drake <pdrake@allplayers.com>  
Reid Vandewiele <marut@cat.pdx.edu>  
Robert Navarro <rnavarro@phiivo.com>  
Ryan Coleman <ryan@puppetlabs.com>  
Scott McLeod <scott.mcleod@theice.com>  
Spencer Krum <spencer@puppetlabs.com>  
William Van Hevelingen <blkperl@cat.pdx.edu> <wvan13@gmail.com>  
Zach Leslie <zach@puppetlabs.com>  