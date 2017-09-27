require 'spec_helper'

describe 'apt_updates fact' do
  subject { Facter.fact(:apt_updates).value }
  after(:each) { Facter.clear }

  describe 'when apt has no updates' do
    before { 
      Facter.fact(:apt_has_updates).stubs(:value).returns false
    }
    it { is_expected.to be nil }
  end

  describe 'when apt has updates' do
    before { 
      Facter.fact(:osfamily).stubs(:value).returns 'Debian'
      File.stubs(:executable?) # Stub all other calls
      Facter::Util::Resolution.stubs(:exec) # Catch all other calls
      File.expects(:executable?).with('/usr/bin/apt-get').returns true
      Facter::Util::Resolution.expects(:exec).with('/usr/bin/apt-get -s -o Debug::NoLocking=true dist-upgrade 2>&1').returns ""+
        "Inst tzdata [2015f-0+deb8u1] (2015g-0+deb8u1 Debian:stable-updates [all])\n"+
        "Conf tzdata (2015g-0+deb8u1 Debian:stable-updates [all])\n"+
        "Inst unhide.rb [13-1.1] (22-2~bpo8+1 Debian Backports:jessie-backports [all])\n"+
        "Conf unhide.rb (22-2~bpo8+1 Debian Backports:jessie-backports [all])\n"
    }
    it { is_expected.to eq(2) }
  end

end
