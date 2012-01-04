# ppa.pp

define apt::ppa() {

  Class['apt'] -> Apt::Ppa[$title]

  exec { "apt-update-${name}":
    command     => "/usr/bin/aptitude update",
    refreshonly => true,
  }

  exec { "add-apt-repository-${name}":
    command => "/usr/bin/add-apt-repository ${name}",
    notify  => Exec["apt-update-${name}"],
    unless => $name? {
      /ppa:(.*)/ => "/bin/cat /etc/apt/sources.list /etc/apt/sources.list.d/* | /bin/egrep '^[^#].*ppa.*$1.*$'",
      default    => "/bin/cat /etc/apt/sources.list /etc/apt/sources.list.d/* | /bin/egrep '^[^#].*${title}.*$'",
    }
  }
}

