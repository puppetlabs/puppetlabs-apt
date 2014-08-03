require 'spec_helper'
describe 'apt::mirror::source', :type => :define do
  let(:file_mirror) { '/etc/apt/mirror.list' }
  let(:title) { 'my_mirror_source' }
  let(:facts) { { :lsbdistid => 'Debian', :lsbdistcodename => 'precise', :concat_basedir => '/tmp'  } }

  context 'precise-updates-i386-nosrc-clean' do
    let(:params) {  {
      'name' => 'precise-updates',
      'mirror_url' => 'http://archive.ubuntu.com/ubuntu',
      'release' => 'precise-updates',
      'components' => 'main restricted universe multiverse',
      'include_src' => false,
      'architecture' => 'i386',
      'clean' => true,
     } }
    it {
      should contain_concat__fragment('apt-mirror-precise-updates.conf').with({
        :target => '/etc/apt/mirror.list',
    }) }

    it {
      should contain_concat__fragment('apt-mirror-precise-updates.conf').with_content("# precise-updates\ndeb-i386  http://archive.ubuntu.com/ubuntu precise-updates main restricted universe multiverse\nclean http://archive.ubuntu.com/ubuntu\n")
    }
  end
  context 'precise-default-src,noclean' do
    let(:params) {  {
      'name' => 'precise',
      'mirror_url' => 'http://archive.ubuntu.com/ubuntu',
      'components' => 'main restricted universe multiverse',
      'include_src' => true,
      'clean' => false,
     } }

    it {
      should contain_concat__fragment('apt-mirror-precise.conf').with({
        :target => '/etc/apt/mirror.list',
    }) }

    it {
      should contain_concat__fragment('apt-mirror-precise.conf').with_content("# precise\ndeb http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse\ndeb-src http://archive.ubuntu.com/ubuntu precise main restricted universe multiverse\n")
    }
  end
end
