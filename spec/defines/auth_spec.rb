# frozen_string_literal: true

require 'spec_helper'

describe 'apt::auth' do
  let(:pre_condition) { 'class { "apt": }' }
  let(:facts) do
    {
      os: {
        family: 'Debian',
        name: 'Debian',
        release: {
          major: '12',
          full: '12.0'
        },
        distro: {
          codename: 'bookworm',
          id: 'Debian'
        }
      }
    }
  end
  let(:title) { 'example' }

  auth_content = <<~CONTENT
    machine apt.example.com
    login aptlogin
    password secret
  CONTENT

  context 'with password as a string' do
    let(:params) { { machine: 'apt.example.com', login: 'aptlogin', password: 'secret' } }

    it { is_expected.to contain_file('/etc/apt/auth.conf.d/example.conf').with(mode: '0600', content: sensitive(auth_content)) }
  end

  context 'with password as sensitive' do
    let(:params) { { machine: 'apt.example.com', login: 'aptlogin', password: sensitive('secret') } }

    it { is_expected.to contain_file('/etc/apt/auth.conf.d/example.conf').with(mode: '0600', content: sensitive(auth_content)) }
  end
end
