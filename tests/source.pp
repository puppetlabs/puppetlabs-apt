class { 'apt': }
apt::source { 'foo':
  location => '',
  release => 'karmic',
  repos => 'main',
  include_src => true,
  required_packages => false,
  key => false,
  key_server => 'keyserver.ubuntu.com',
  pin => '600'
}

# test two sources with the same key
apt::source { "debian_testing":
  location => "http://debian.mirror.iweb.ca/debian/",
  release => "testing",
  repos => "main contrib non-free",
  key => "55BE302B",
  key_server => "subkeys.pgp.net",
  pin => "-10"
}
apt::source { "debian_unstable":
  location => "http://debian.mirror.iweb.ca/debian/",
  release => "unstable",
  repos => "main contrib non-free",
  key => "55BE302B",
  key_server => "subkeys.pgp.net",
  pin => "-10"
}
