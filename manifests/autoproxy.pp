# autoproxy.pp

# include this class to tell client to look for
# an _apt_proxy._tcp provider via avahi

class apt::autoproxy {
  package { 'squid-deb-proxy-client': }

  apt::conf { 'autoproxy':
    ensure   => present,
    priority => '30',
    content  => 'Acquire::http::ProxyAutoDetect "/usr/share/squid-deb-proxy-client/apt-avahi-discover";',
  }
}
