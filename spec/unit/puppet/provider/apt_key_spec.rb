# frozen_string_literal: true

require 'spec_helper'

describe Puppet::Type.type(:apt_key).provider(:apt_key) do
  describe 'instances' do
    it 'has an instance method' do
      expect(described_class).to respond_to :instances
    end
  end

  describe 'prefetch' do
    it 'has a prefetch method' do
      expect(described_class).to respond_to :prefetch
    end
  end

  context 'with self.instances no key' do
    before :each do
      # Unable to remove `master` from below terminology as it relies on outside code
      allow(described_class).to receive(:apt_key).with(
        ['adv', '--no-tty', '--list-keys', '--with-colons', '--fingerprint', '--fixed-list-mode'],
      ).and_return('uid:-::::1284991450::07BEBE04F4AE4A8E885A761325717D8509D9C1DC::Ubuntu Extras Archive Automatic Signing Key <ftpmaster@ubuntu.com>::::::::::0:')
    end

    it 'returns no resources' do
      expect(described_class.instances.size).to eq(0)
    end
  end

  context 'with self.instances multiple keys' do
    before :each do
      command_output = <<~OUTPUT
        Executing: gpg --ignore-time-conflict --no-options --no-default-keyring --homedir /tmp/tmp.DU0GdRxjmE --no-auto-check-trustdb --trust-model always --keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg --keyring /etc/apt/trusted.gpg.d/puppetlabs-pc1-keyring.gpg --no-tty --list-keys --with-colons --fingerprint --fixed-list-mode
        tru:t:1:1549900774:0:3:1:5
        pub:-:1024:17:40976EAF437D05B5:1095016255:::-:::scESC:
        fpr:::::::::630239CC130E1A7FD81A27B140976EAF437D05B5:
        uid:-::::1095016255::B84AE656F4F5A826C273A458512EF8E282754CE1::Ubuntu Archive Automatic Signing Key <ftpmaster@ubuntu.com>:
        sub:-:2048:16:251BEFF479164387:1095016263::::::e:
        pub:-:1024:17:46181433FBB75451:1104433784:::-:::scSC:
        fpr:::::::::C5986B4F1257FFA86632CBA746181433FBB75451:
      OUTPUT
      allow(described_class).to receive(:apt_key).with(
        ['adv', '--no-tty', '--list-keys', '--with-colons', '--fingerprint', '--fixed-list-mode'],
      ).and_return(command_output)
    end

    it 'returns 2 resources' do # rubocop:disable RSpec/MultipleExpectations
      expect(described_class.instances.size).to eq(2)
      expect(described_class.instances[0].name).to eq('630239CC130E1A7FD81A27B140976EAF437D05B5')
      expect(described_class.instances[0].id).to eq('40976EAF437D05B5')
      expect(described_class.instances[0].expired).to be_falsey
      expect(described_class.instances[1].name).to eq('C5986B4F1257FFA86632CBA746181433FBB75451')
      expect(described_class.instances[1].id).to eq('46181433FBB75451')
      expect(described_class.instances[1].expired).to be_falsey
    end
  end

  context 'with self.instances expired subkeys' do
    before :each do
      command_output = <<~OUTPUT
        Executing: /tmp/apt-key-gpghome.0lru3TZOtF/gpg.1.sh --list-keys --with-colons --fingerprint 0x7721F63BD38B4796
        tru:t:1:1682141947:0:3:1:5
        pub:-:4096:1:7721F63BD38B4796:1460440275:::-:::scSC::::::23::0:
        fpr:::::::::EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796:
        uid:-::::1460440275::7830FE2652F718E78EEE5881B7FA2CE8E3533BE4::Google Inc. (Linux Packages Signing Authority) <linux-packages-keymaster@google.com>::::::::::0:
        sub:e:4096:1:1397BC53640DB551:1460440520:1555048520:::::s::::::23:
        fpr:::::::::3B068FB4789ABE4AEFA3BB491397BC53640DB551:
        sub:e:4096:1:6494C6D6997C215E:1485225932:1579833932:::::s::::::23:
        fpr:::::::::3E50F6D3EC278FDEB655C8CA6494C6D6997C215E:
      OUTPUT
      allow(described_class).to receive(:apt_key).with(
        ['adv', '--no-tty', '--list-keys', '--with-colons', '--fingerprint', '--fixed-list-mode'],
      ).and_return(command_output)
    end

    it 'returns 1 expired resource' do
      expect(described_class.instances.size).to eq(1)
      expect(described_class.instances[0].expired).to be_truthy
    end
  end

  context 'with create apt_key resource' do
    it 'apt_key with content set and source nil' do
      expect(described_class).to receive(:apt_key).with(['adv', '--no-tty',
                                                         '--keyserver',
                                                         :'keyserver.ubuntu.com',
                                                         '--recv-keys',
                                                         'C105B9DE'])
      resource = Puppet::Type::Apt_key.new(name: 'source and content nil',
                                           id: 'C105B9DE',
                                           ensure: 'present')

      provider = described_class.new(resource)
      expect(provider).not_to be_exist
      provider.create
      expect(provider).to be_exist
    end

    it 'apt_key content and source nil, options set' do
      expect(described_class).to receive(:apt_key).with(['adv', '--no-tty',
                                                         '--keyserver',
                                                         :'keyserver.ubuntu.com',
                                                         '--keyserver-options',
                                                         'jimno',
                                                         '--recv-keys',
                                                         'C105B9DE'])
      resource = Puppet::Type::Apt_key.new(name: 'source and content nil',
                                           id: 'C105B9DE',
                                           options: 'jimno',
                                           ensure: 'present')

      provider = described_class.new(resource)
      expect(provider).not_to be_exist
      provider.create
      expect(provider).to be_exist
    end

    it 'apt_key with content set' do # rubocop:disable RSpec/MultipleExpectations
      expect(described_class).to receive(:apt_key).with(array_including('add', kind_of(String)))
      resource = Puppet::Type::Apt_key.new(name: 'gsd',
                                           id: 'C105B9DE',
                                           content: 'asad',
                                           ensure: 'present')

      provider = described_class.new(resource)
      expect(provider).not_to be_exist
      expect(provider).to receive(:tempfile).and_return(Tempfile.new('foo'))
      provider.create
      expect(provider).to be_exist
    end

    it 'apt_key with source set' do # rubocop:disable RSpec/MultipleExpectations
      expect(described_class).to receive(:apt_key).with(array_including('add', kind_of(String)))
      resource = Puppet::Type::Apt_key.new(name: 'gsd',
                                           id: 'C105B9DE',
                                           source: 'ftp://bla/herpderp.gpg',
                                           ensure: 'present')

      provider = described_class.new(resource)
      expect(provider).not_to be_exist
      expect(provider).to receive(:source_to_file).and_return(Tempfile.new('foo'))
      provider.create
      expect(provider).to be_exist
    end

    it 'apt_key with source and weak ssl verify set' do # rubocop:disable RSpec/MultipleExpectations
      expect(described_class).to receive(:apt_key).with(array_including('add', kind_of(String)))
      resource = Puppet::Type::Apt_key.new(name: 'gsd',
                                           id: 'C105B9DE',
                                           source: 'https://bla/herpderp.gpg',
                                           ensure: 'present',
                                           weak_ssl: true)

      provider = described_class.new(resource)
      expect(provider).not_to be_exist
      expect(provider).to receive(:source_to_file).and_return(Tempfile.new('foo'))
      provider.create
      expect(provider).to be_exist
    end

    describe 'different valid id keys' do
      hash_of_keys = {
        '32bit key id' => 'EF8D349F',
        '64bit key id' => '7F438280EF8D349F',
        '160bit key fingerprint' => '6F6B15509CF8E59E6E469F327F438280EF8D349F',
        '32bit key id lowercase' => 'EF8D349F'.downcase,
        '64bit key id lowercase' => '7F438280EF8D349F'.downcase,
        '160bit key fingerprint lowercase' => '6F6B15509CF8E59E6E469F327F438280EF8D349F'.downcase,
        '32bit key id 0x formatted' => '0xEF8D349F',
        '64bit key id 0x formatted' => '0x7F438280EF8D349F',
        '160bit key fingerprint 0x formatted' => '0x6F6B15509CF8E59E6E469F327F438280EF8D349F'
      }
      hash_of_keys.each do |key_type, value|
        it "#{key_type} #{value} is valid" do
          expect(described_class).to receive(:apt_key).with(array_including('adv', '--no-tty',
                                                                            '--keyserver',
                                                                            :'keyserver.ubuntu.com',
                                                                            '--recv-keys'))
          resource = Puppet::Type::Apt_key.new(name: 'source and content nil',
                                               id: value,
                                               ensure: 'present')

          provider = described_class.new(resource)
          expect(provider).not_to be_exist
          provider.create
          expect(provider).to be_exist
        end
      end
    end

    it 'apt_key with invalid key length' do
      expect {
        Puppet::Type::Apt_key.new(name: 'source and content nil',
                                  id: '1',
                                  ensure: 'present')
      }.to raise_error(Puppet::ResourceError, %r{Parameter id failed on Apt_key})
    end
  end

  context 'with key_line_hash function' do
    it 'matches rsa' do
      expect(described_class.key_line_hash('pub:-:1024:1:40976EAF437D05B5:1095016255:::-:::scESC:', ['fpr:::::::::630239CC130E1A7FD81A27B140976EAF437D05B5:'])).to include(
        key_expiry: nil,
        key_fingerprint: '630239CC130E1A7FD81A27B140976EAF437D05B5',
        key_long: '40976EAF437D05B5',
        key_short: '437D05B5',
        key_size: '1024',
        key_type: :rsa,
      )
    end

    it 'matches dsa' do
      expect(described_class.key_line_hash('pub:-:1024:17:40976EAF437D05B5:1095016255:::-:::scESC:', ['fpr:::::::::630239CC130E1A7FD81A27B140976EAF437D05B5:'])).to include(
        key_expiry: nil,
        key_fingerprint: '630239CC130E1A7FD81A27B140976EAF437D05B5',
        key_long: '40976EAF437D05B5',
        key_short: '437D05B5',
        key_size: '1024',
        key_type: :dsa,
      )
    end

    it 'matches ecc' do
      expect(described_class.key_line_hash('pub:-:1024:18:40976EAF437D05B5:1095016255:::-:::scESC:', ['fpr:::::::::630239CC130E1A7FD81A27B140976EAF437D05B5:'])).to include(
        key_expiry: nil,
        key_fingerprint: '630239CC130E1A7FD81A27B140976EAF437D05B5',
        key_long: '40976EAF437D05B5',
        key_short: '437D05B5',
        key_size: '1024',
        key_type: :ecc,
      )
    end

    it 'matches ecdsa' do
      expect(described_class.key_line_hash('pub:-:1024:19:40976EAF437D05B5:1095016255:::-:::scESC:', ['fpr:::::::::630239CC130E1A7FD81A27B140976EAF437D05B5:'])).to include(
        key_expiry: nil,
        key_fingerprint: '630239CC130E1A7FD81A27B140976EAF437D05B5',
        key_long: '40976EAF437D05B5',
        key_short: '437D05B5',
        key_size: '1024',
        key_type: :ecdsa,
      )
    end
  end
end
