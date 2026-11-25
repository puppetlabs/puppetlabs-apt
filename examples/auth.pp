include 'apt'

apt::auth { 'example':
  machine  => 'apt.example.com',
  login    => 'insecure-username',
  password => 'insecure-password',
}

apt::source { 'puppetlabs':
  location => 'https://apt-enterprise.puppetlabs.com',
  repos    => 'main',
  keyring  => '/usr/share/keyrings/puppetlabs.gpg',
  auth     => {
    login    => 'insecure-username',
    password => 'insecure-password',
  },
}
