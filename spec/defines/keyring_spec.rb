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

      context 'with dearmor => true' do
        let(:params) do
          super().merge(dearmor: true)
        end

        it {
          is_expected.to contain_exec('dearmor-namevar')
            .that_subscribes_to('File[/etc/apt/keyrings/namevar]')
            .with(
              {
                command: 'gpg --dearmor /etc/apt/keyrings/namevar && mv /etc/apt/keyrings/namevar.gpg /etc/apt/keyrings/namevar',
                refreshonly: true,
              },
            )
        }
      end
    end
  end
end
