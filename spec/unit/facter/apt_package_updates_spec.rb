# frozen_string_literal: true

require 'spec_helper'

describe 'apt_package_updates fact' do
  subject { Facter.fact(:apt_package_updates).value }

  before(:each) { Facter.clear }

  describe 'when apt has no updates' do
    before(:each) do
      allow(Facter.fact(:apt_has_updates)).to receive(:value).and_return(false)
    end

    it { is_expected.to be_nil }
  end

  describe 'when apt has updates' do
    before(:each) do
      allow(Facter.fact(:'os.family')).to receive(:value).and_return('Debian')
      allow(File).to receive(:executable?) # Stub all other calls
      allow(Facter::Core::Execution).to receive(:execute) # Catch all other calls
      allow(File).to receive(:executable?).with('/usr/bin/apt-get').and_return(true)
      apt_output = "Inst tzdata [2015f-0+deb8u1] (2015g-0+deb8u1 Debian:stable-updates [all])\n" \
                   "Conf tzdata (2015g-0+deb8u1 Debian:stable-updates [all])\n" \
                   "Inst unhide.rb [13-1.1] (22-2~bpo8+1 Debian Backports:-backports [all])\n" \
                   "Conf unhide.rb (22-2~bpo8+1 Debian Backports:-backports [all])\n"
      allow(Facter::Core::Execution).to receive(:execute).with('/usr/bin/apt-get -s -o Debug::NoLocking=true upgrade 2>&1').and_return(apt_output)
    end

    it { is_expected.to eq(['tzdata', 'unhide.rb']) }
  end
end
