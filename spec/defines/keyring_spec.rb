# frozen_string_literal: true

require 'spec_helper'

describe 'apt::keyring' do
  let(:title) { 'namevar' }
  let(:params) do
    {
      source: 'http://apt.puppetlabs.com/pubkey.gpg',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end

  describe 'ensure => refreshed' do
    let :params do
      {
        ensure: 'refreshed',
        name: 'puppetlabs.gpg',
        source: 'http://apt.puppetlabs.com/pubkey.gpg',
      }
    end

    it {
      is_expected.to contain_exec('check_keyring_puppetlabs.gpg').with(
      command: 'rm /etc/apt/keyrings/puppetlabs.gpg',
      onlyif: 'test -f /etc/apt/keyrings/puppetlabs.gpg && gpg --show-keys --list-options show-sig-expire /etc/apt/keyrings/puppetlabs.gpg | grep expired',
    )
    }
  end
end
