class { 'apt::mirror': }
::apt::mirror::source { 'precise-updates':
  mirror_url   => 'http://archive.ubuntu.com/ubuntu',
  release      => 'precise-updates',
  components   => 'main restricted universe multiverse',
  include_src  => false,
  architecture => i386,
  clean        => true,
}

::apt::mirror::source { 'precise':
  mirror_url   => 'http://archive.ubuntu.com/ubuntu',
  components   => 'main restricted universe multiverse',
  include_src  => true,
  clean        => false,
}
