# frozen_string_literal: true

require 'spec_helper'

describe Puppet::Type.type(:apt_key).provider(:apt_key_missing) do
  let(:resource) { Puppet::Type.type(:apt_key).new(id: '6F6B15509CF8E59E6E469F327F438280EF8D349F', provider: :apt_key_missing) }
  let(:provider) { resource.provider }
  let(:message) { %r{apt-key command is not available.*apt::keyring} }

  it 'fails in exists? with directions to use apt::keyring' do
    expect { provider.exists? }.to raise_error(Puppet::Error, message)
  end

  it 'fails in create with directions to use apt::keyring' do
    expect { provider.create }.to raise_error(Puppet::Error, message)
  end

  it 'fails in destroy with directions to use apt::keyring' do
    expect { provider.destroy }.to raise_error(Puppet::Error, message)
  end
end
