require 'spec_helper'
describe 'apt::mirror', :type => :class do
  let(:file_mirror) { '/etc/apt/mirror.list' }
  let(:facts) { { :lsbdistid => 'Debian', :concat_basedir => '/tmp'  } }
  it { should contain_package("apt-mirror").with_ensure('present') }

  it {
    should create_concat("/etc/apt/mirror.list").with({
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
    })
  }

  let(:params) { { 
    'base_path' => '/apt-mirror',
    'defaultarch' => 'amd64',
    'nthreads' => 10,
    'name' => 'testname',
  } }

  it {
    should contain_concat__fragment('apt-mirror-testname.conf').with({
      :target => '/etc/apt/mirror.list',
  }) }

  it {
    should contain_concat__fragment('apt-mirror-testname.conf').with_content("#### Managed by puppet, all local changes will be reverted ###\n############# config ##################\nset base_path         /apt-mirror\nset mirror_path       $base_path/mirror\nset skel_path         $base_path/skel\nset var_path          $base_path/var\nset cleanscript       $base_path/clean.sh\nset defaultarch       amd64\nset postmirror_script $var_path/postmirror.sh\nset run_postmirror    0\nset nthreads          10\nset _tilde            0\n############# end config ##############\n\n")
  }

end
