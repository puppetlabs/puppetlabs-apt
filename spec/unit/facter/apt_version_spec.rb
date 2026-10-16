# frozen_string_literal: true

require 'spec_helper'

describe 'apt_version fact' do
  subject(:version) { Facter.fact(:apt_version).value }

  before(:each) do
    Facter.clear
    allow(Facter.fact(:'os.family')).to receive(:value).and_return('Debian')
    allow(File).to receive(:executable?).with('/usr/bin/apt-get').and_return(true)
    allow(Facter::Core::Execution).to receive(:execute).with('/usr/bin/apt-get --version', on_fail: nil).and_return(output)
  end

  {
    "apt 1.6.17 (amd64)\nSupported modules:\n" => '1.6.17',
    "apt 2.4.14 (amd64)\n" => '2.4.14',
    "apt 2.6.1+deb12u1 (amd64)\n" => '2.6.1',
    "apt 3.0.3 (arm64)\n" => '3.0.3',
    "unexpected output\n" => nil,
    '' => nil,
    nil => nil,
  }.each do |text, version|
    context "with output #{text.inspect}" do
      let(:output) { text }

      it { is_expected.to eq(version) }
    end
  end

  context 'without apt-get' do
    let(:output) { nil }

    before(:each) do
      allow(File).to receive(:executable?).with('/usr/bin/apt-get').and_return(false)
    end

    it 'does not execute apt-get', :aggregate_failures do
      expect(Facter::Core::Execution).not_to receive(:execute)
      expect(version).to be_nil
    end
  end

  context 'on a non-Debian family' do
    let(:output) { nil }

    before(:each) do
      allow(Facter.fact(:'os.family')).to receive(:value).and_return('RedHat')
    end

    it { is_expected.to be_nil }
  end
end
