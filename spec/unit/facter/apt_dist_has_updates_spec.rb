# frozen_string_literal: true

require 'spec_helper'

describe 'apt_has_dist_updates fact' do
  subject { Facter.fact(:apt_has_dist_updates).value }

  before(:each) { Facter.clear }

  describe 'on non-Debian distro' do
    before(:each) do
      allow(Facter.fact(:'os.family')).to receive(:value).once.and_return('Redhat')
    end

    it { is_expected.to be_nil }
  end

  describe 'on Debian based distro missing apt-get' do
    before(:each) do
      allow(Facter.fact(:'os.family')).to receive(:value).once.and_return('Debian')
      allow(File).to receive(:executable?) # Stub all other calls
      allow(File).to receive(:executable?).with('/usr/bin/apt-get').and_return(false)
    end

    it { is_expected.to be_nil }
  end

  describe 'on Debian based distro' do
    before(:each) do
      allow(Facter.fact(:'os.family')).to receive(:value).once.and_return('Debian')
      allow(File).to receive(:executable?) # Stub all other calls
      allow(Facter::Core::Execution).to receive(:execute) # Catch all other calls
      allow(File).to receive(:executable?).with('/usr/bin/apt-get').and_return(true)
      allow(Facter::Core::Execution).to receive(:execute).with('/usr/bin/apt-get -s -o Debug::NoLocking=true upgrade 2>&1').and_return('test')
      apt_output = "Inst extremetuxracer [2015f-0+deb8u1] (2015g-0+deb8u1 Debian:stable-updates [all])\n" \
                   "Conf extremetuxracer (2015g-0+deb8u1 Debian:stable-updates [all])\n" \
                   "Inst planet.rb [13-1.1] (22-2~bpo8+1 Debian Backports:stretch-backports [all])\n" \
                   "Conf planet.rb (22-2~bpo8+1 Debian Backports:stretch-backports [all])\n"
      allow(Facter::Core::Execution).to receive(:execute).with('/usr/bin/apt-get -s -o Debug::NoLocking=true dist-upgrade 2>&1').and_return(apt_output)
    end

    it { is_expected.to be true }
  end
end
