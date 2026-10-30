# frozen_string_literal: true

require 'spec_helper'

describe Puppet::Type.type(:apt_key).provider(:gpg_keyring) do
  let(:fingerprint) { '6F6B15509CF8E59E6E469F327F438280EF8D349F' }
  let(:resource) { Puppet::Type.type(:apt_key).new(id: fingerprint, content: 'KEY', provider: :gpg_keyring) }
  let(:provider) { resource.provider }

  describe 'instances' do
    it 'lists the keyring files' do
      listing = <<~OUTPUT
        pub:-:4096:1:7F438280EF8D349F:1396374374:::-:::scESC:::::::
        fpr:::::::::#{fingerprint}:
        uid:-::::1396374374::ABCDEF::Puppet Labs Release Key:
      OUTPUT
      allow(Dir).to receive(:glob).with('/etc/apt/keyrings/*.gpg').and_return(["/etc/apt/keyrings/#{fingerprint}.gpg"])
      allow(described_class).to receive(:gpg)
        .with('--no-tty', '--show-keys', '--with-colons', '--fingerprint', '--fixed-list-mode', "/etc/apt/keyrings/#{fingerprint}.gpg")
        .and_return(listing)

      instances = described_class.instances
      expect(instances.size).to eq(1)
      expect(instances.first.fingerprint).to eq(fingerprint)
    end
  end

  describe 'create' do
    let(:tmp) { instance_double(File, path: '/tmp/apt_key123') }

    before :each do
      allow(FileUtils).to receive(:mkdir_p)
      allow(File).to receive(:chmod)
    end

    it 'de-armors content into the keyring directory' do
      allow(provider).to receive(:tempfile).with('KEY').and_return(tmp)
      expect(provider).to receive(:gpg)
        .with('--no-tty', '--yes', '--dearmor', '--output', "/etc/apt/keyrings/#{fingerprint}.gpg", '/tmp/apt_key123')
      provider.create
    end

    it 'exports a key fetched from a keyserver' do
      keyserver_resource = Puppet::Type.type(:apt_key).new(id: fingerprint, server: 'keyserver.ubuntu.com', provider: :gpg_keyring)
      keyserver_provider = keyserver_resource.provider
      allow(Dir).to receive(:mktmpdir).and_yield('/tmp/home')
      expect(keyserver_provider).to receive(:gpg)
        .with('--no-tty', '--homedir', '/tmp/home', '--keyserver', 'keyserver.ubuntu.com', '--recv-keys', fingerprint).ordered
      expect(keyserver_provider).to receive(:gpg)
        .with('--no-tty', '--yes', '--homedir', '/tmp/home', '--output', "/etc/apt/keyrings/#{fingerprint}.gpg", '--export', fingerprint).ordered
      keyserver_provider.create
    end
  end

  describe 'destroy' do
    it 'removes the keyring file' do
      expect(FileUtils).to receive(:rm_f).with(["/etc/apt/keyrings/#{fingerprint}.gpg"])
      provider.destroy
    end
  end
end
