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
end
