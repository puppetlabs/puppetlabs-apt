require 'spec_helper'
describe 'apt::builddep', :type => :define do

  let(:facts) { { :lsbdistid => 'Debian' } }
  let(:title) { 'my_package' }

  describe "should require apt-get update" do
    it { should contain_exec("apt_update").with({
        'command' => "/usr/bin/apt-get update",
        'refreshonly' => true
      })
    }
    it { should contain_anchor("apt::builddep::my_package").with({
        'require' => 'Class[Apt::Update]',
      })
    }
  end

  describe "should not refreshonly by default" do
    it { should contain_exec("apt-builddep-my_package").with({
      'refreshonly' => false
    })
  }
  end

  describe "should not refreshonly when told not to" do
    let(:params) { { :refreshonly => false } }

    it { should contain_exec("apt-builddep-my_package").with({
      'refreshonly' => false
    })
  }
  end

  describe "should refreshonly when told to" do
    let(:params) { { :refreshonly => true } }

    it { should contain_exec("apt-builddep-my_package").with({
      'refreshonly' => true
    })
  }
  end

  describe "should fail with an invalid refreshonly param" do
    let(:params) { { :refreshonly => 'frog blast the vent core' } }

    it do
      expect {
        should contain_exec("apt-builddep-my_package")
      }.to raise_error(Puppet::Error, /is not a boolean/)
    end
  end

end
