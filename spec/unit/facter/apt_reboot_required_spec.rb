# frozen_string_literal: true

require 'spec_helper'

describe 'apt_reboot_required fact' do
  subject { Facter.fact(:apt_reboot_required).value }

  before(:each) { Facter.clear }

  describe 'if a reboot is required' do
    before(:each) do
      allow(Facter.fact(:'os.family')).to receive(:value).and_return('Debian')
      allow(File).to receive(:file?).and_return(true)
      allow(File).to receive(:file?).once.with('/var/run/reboot-required').and_return(true)
    end

    it { is_expected.to be true }
  end

  describe 'if a reboot is not required' do
    before(:each) do
      allow(Facter.fact(:'os.family')).to receive(:value).and_return('Debian')
      allow(File).to receive(:file?).and_return(true)
      allow(File).to receive(:file?).once.with('/var/run/reboot-required').and_return(false)
    end

    it { is_expected.to be false }
  end
end
