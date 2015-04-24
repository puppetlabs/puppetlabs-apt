require 'spec_helper'

describe 'apt_reboot_required fact' do
  subject { Facter.fact(:apt_reboot_required).value }
  after(:each) { Facter.clear }

  describe 'if a reboot is required' do
    before {
      Facter.fact(:osfamily).stubs(:value).returns 'Debian'
      File.stubs(:file?).returns true
    }
    it { expect Facter.fact(:apt_reboot_required).to eq(true) }
  end

  describe 'if a reboot is not required' do
    before {
      Facter.fact(:osfamily).stubs(:value).returns 'Debian'
      File.stubs(:file?).returns false
    }
    it { expect Facter.fact(:apt_reboot_required).to eq(false) }
  end

end
