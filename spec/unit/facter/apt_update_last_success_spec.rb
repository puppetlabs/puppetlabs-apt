# frozen_string_literal: true

require 'spec_helper'

describe 'apt_update_last_success fact' do
  subject { Facter.fact(:apt_update_last_success).value }

  before(:each) { Facter.clear }

  describe 'on Debian based distro which has not yet created the update-success-stamp file' do
    it 'has a value of -1' do
      allow(Facter.fact(:'os.family')).to receive(:value).and_return('Debian')
      allow(File).to receive(:exist?).with('/var/lib/apt/periodic/update-success-stamp').and_return(false)
      expect(subject).to eq(-1)
    end
  end

  describe 'on Debian based distro which has created the update-success-stamp' do
    it 'has the value of the mtime of the file' do
      allow(Facter.fact(:'os.family')).to receive(:value).and_return('Debian')
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:mtime).and_return(1_407_660_561)
      expect(subject).to eq(1_407_660_561)
    end
  end
end
