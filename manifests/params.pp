class apt::params {
  $root           = '/etc/apt'
  $provider       = '/usr/bin/apt-get'
  $sources_list_d = "${root}/sources.list.d"
}
