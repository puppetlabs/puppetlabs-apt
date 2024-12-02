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

      context 'with checksum verification enabled' do
        let (:params) do
          {
            source: 'https://apt.puppetlabs.com/pubkey.gpg',
            checksum: 'sha256',
            checksum_value: '9d7a61ab06b18454e9373edec4fc7c87f9a91bacfc891893ba0da37a33069771',
          }
        end

        it { is_expected.to compile }
      end
    end
  end
end
