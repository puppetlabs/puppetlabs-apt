# frozen_string_literal: true

require 'spec_helper'

describe 'apt_security_updates fact' do
  subject { Facter.fact(:apt_security_dist_updates).value }

  before(:each) { Facter.clear }

  describe 'when apt has no updates' do
    before(:each) do
      allow(Facter.fact(:apt_has_dist_updates)).to receive(:value).and_return(false)
    end

    it { is_expected.to be_nil }
  end

  describe 'when apt has security updates' do
    before(:each) do
      allow(Facter.fact(:'os.family')).to receive(:value).and_return('Debian')
      allow(File).to receive(:executable?) # Stub all other calls
      allow(Facter::Core::Execution).to receive(:execute) # Catch all other calls
      allow(File).to receive(:executable?).with('/usr/bin/apt-get').and_return(true)
      allow(Facter::Core::Execution).to receive(:execute).with('/usr/bin/apt-get -s -o Debug::NoLocking=true upgrade 2>&1').and_return('test')
      allow(File).to receive(:executable?).with('/usr/bin/apt-get').and_return(true)
      allow(Facter::Core::Execution).to receive(:execute).with('/usr/bin/apt-get -s -o Debug::NoLocking=true dist-upgrade 2>&1').and_return(apt_get_upgrade_output)
    end

    describe 'on Debian' do
      let(:apt_get_upgrade_output) do
        "Inst extremetuxracer [2015f-0+deb8u1] (2015g-0+deb8u1 Debian:stable-updates [all])\n" \
          "Conf extremetuxracer (2015g-0+deb8u1 Debian:stable-updates [all])\n" \
          "Inst planet.rb [13-1.1] (22-2~bpo8+1 Debian Backports:-backports [all])\n" \
          "Conf planet.rb (22-2~bpo8+1 Debian Backports:-backports [all])\n" \
          "Inst vim [7.52.1-5] (7.52.1-5+deb9u2 Debian-Security:9/stable [amd64]) []\n" \
          "Conf vim (7.52.1-5+deb9u2 Debian-Security:9/stable [amd64])\n" \
      end

      it { is_expected.to eq(1) }
    end

    describe 'on Ubuntu' do
      let(:apt_get_upgrade_output) do
        "Inst extremetuxracer [2016f-0ubuntu0.18.04] (2016j-0ubuntu0.18.04 Ubuntu:18.04/xenial-security, Ubuntu:18.04/xenial-updates [all])\n" \
          "Conf extremetuxracer (2016j-0ubuntu0.18.04 Ubuntu:18.04/xenial-security, Ubuntu:18.04/xenial-updates [all])\n" \
          "Inst vim [7.47.0-1ubuntu2] (7.47.0-1ubuntu2.2 Ubuntu:18.04/xenial-security [amd64]) []\n" \
          "Conf vim (7.47.0-1ubuntu2.2 Ubuntu:18.04/xenial-security [amd64])\n" \
          "Inst onioncircuits [2:3.3.10-4ubuntu2] (2:3.3.10-4ubuntu2.3 Ubuntu:18.04/xenial-updates [amd64])\n" \
          "Conf onioncircuits (2:3.3.10-4ubuntu2.3 Ubuntu:18.04/xenial-updates [amd64])\n"
      end

      it { is_expected.to eq(2) }
    end
  end
end
