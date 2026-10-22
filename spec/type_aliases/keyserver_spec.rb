# frozen_string_literal: true

require 'spec_helper'

describe 'Apt::Keyserver' do
  describe 'valid handling' do
    [
      'keyserver.ubuntu.com',
      'keyserver.ubuntu.com:11371',
      'hkp://keyserver.ubuntu.com',
      'hkp://keyserver.ubuntu.com:80',
      'hkps://keys.openpgp.org',
      'http://keyserver.ubuntu.com',
      'https://keyserver.ubuntu.com/pks',
    ].each do |value|
      describe value.inspect do
        it { is_expected.to allow_value(value) }
      end
    end
  end

  describe 'invalid handling' do
    [
      '',
      '-pgp.mit.edu',
      '.pgp.mit.edu',
      'pgp.mit.edu.',
      'abc://pgp.mit.edu',
      'hkp://pgp.mit.edu:',
      'hkp://pgp.mit.edu:8008080',
      'two bottles of rum',
    ].each do |value|
      describe value.inspect do
        it { is_expected.not_to allow_value(value) }
      end
    end
  end
end
