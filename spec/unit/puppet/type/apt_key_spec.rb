require 'spec_helper'
require 'puppet'

describe Puppet::Type::type(:apt_key) do
  context 'only namevar 32bit key id' do
    let(:resource) { Puppet::Type.type(:apt_key).new(
      :id => '4BD6EC30'
    )}
    it 'id is set' do
      resource[:id].should eq '4BD6EC30'
    end

    it 'name is set to id' do
      resource[:name].should eq '4BD6EC30'
    end

    it 'keyserver is default' do
      resource[:server].should eq :'keyserver.ubuntu.com'
    end

    it 'source is not set' do
      resource[:source].should eq nil
    end

    it 'content is not set' do
      resource[:content].should eq nil
    end
  end

  context 'with a lowercase 32bit key id' do
    let(:resource) { Puppet::Type.type(:apt_key).new(
      :id => '4bd6ec30'
    )}
    it 'id is set' do
      resource[:id].should eq '4BD6EC30'
    end
  end

  context 'with a 64bit key id' do
    let(:resource) { Puppet::Type.type(:apt_key).new(
      :id => 'FFFFFFFF4BD6EC30'
    )}
    it 'id is set' do
      resource[:id].should eq 'FFFFFFFF4BD6EC30'
    end
  end

  context 'with a 0x formatted key id' do
    let(:resource) { Puppet::Type.type(:apt_key).new(
      :id => '0x4BD6EC30'
    )}
    it 'id is set' do
      resource[:id].should eq '4BD6EC30'
    end
  end

  context 'with a 0x formatted lowercase key id' do
    let(:resource) { Puppet::Type.type(:apt_key).new(
      :id => '0x4bd6ec30'
    )}
    it 'id is set' do
      resource[:id].should eq '4BD6EC30'
    end
  end

  context 'with a 0x formatted 64bit key id' do
    let(:resource) { Puppet::Type.type(:apt_key).new(
      :id => '0xFFFFFFFF4BD6EC30'
    )}
    it 'id is set' do
      resource[:id].should eq 'FFFFFFFF4BD6EC30'
    end
  end

  context 'with source' do
    let(:resource) { Puppet::Type.type(:apt_key).new(
      :id => '4BD6EC30',
      :source => 'http://apt.puppetlabs.com/pubkey.gpg'
    )}

    it 'source is set to the URL' do
      resource[:source].should eq 'http://apt.puppetlabs.com/pubkey.gpg'
    end
  end

  context 'with content' do
    let(:resource) { Puppet::Type.type(:apt_key).new(
      :id => '4BD6EC30',
      :content => 'http://apt.puppetlabs.com/pubkey.gpg'
    )}

    it 'content is set to the string' do
      resource[:content].should eq 'http://apt.puppetlabs.com/pubkey.gpg'
    end
  end

  context 'with keyserver' do
    let(:resource) { Puppet::Type.type(:apt_key).new(
      :id => '4BD6EC30',
      :server => 'http://keyring.debian.org'
    )}

    it 'keyserver is set to Debian' do
      resource[:server].should eq 'http://keyring.debian.org'
    end
  end

  context 'validation' do
    it 'raises an error if content and source are set' do
      expect { Puppet::Type.type(:apt_key).new(
        :id      => '4BD6EC30',
        :source  => 'http://apt.puppetlabs.com/pubkey.gpg',
        :content => 'Completely invalid as a GPG key'
      )}.to raise_error(/content and source are mutually exclusive/)
    end

    it 'raises an error if a weird length key is used' do
      expect { Puppet::Type.type(:apt_key).new(
        :id      => 'F4BD6EC30',
        :source  => 'http://apt.puppetlabs.com/pubkey.gpg',
        :content => 'Completely invalid as a GPG key'
      )}.to raise_error(/Valid values match/)
    end

    it 'raises an error when an invalid URI scheme is used in source' do
      expect { Puppet::Type.type(:apt_key).new(
        :id      => '4BD6EC30',
        :source  => 'hkp://pgp.mit.edu'
      )}.to raise_error(/Valid values match/)
    end

    it 'allows the http URI scheme in source' do
      expect { Puppet::Type.type(:apt_key).new(
        :id      => '4BD6EC30',
        :source  => 'http://pgp.mit.edu'
      )}.to_not raise_error
    end

    it 'allows the https URI scheme in source' do
      expect { Puppet::Type.type(:apt_key).new(
        :id      => '4BD6EC30',
        :source  => 'https://pgp.mit.edu'
      )}.to_not raise_error
    end

    it 'allows the https URI with username and password' do
      expect { Puppet::Type.type(:apt_key).new(
          :id      => '4BD6EC30',
          :source  => 'https://testme:Password2@pgp.mit.edu'
      )}.to_not raise_error
    end

    it 'allows the ftp URI scheme in source' do
      expect { Puppet::Type.type(:apt_key).new(
        :id      => '4BD6EC30',
        :source  => 'ftp://pgp.mit.edu'
      )}.to_not raise_error
    end

    it 'allows an absolute path in source' do
      expect { Puppet::Type.type(:apt_key).new(
        :id      => '4BD6EC30',
        :source  => '/path/to/a/file'
      )}.to_not raise_error
    end

    it 'allows 5-digit ports' do
      expect { Puppet::Type.type(:apt_key).new(
        :id      => '4BD6EC30',
        :source  => 'http://pgp.mit.edu:12345/key'
      )}.to_not raise_error
    end

    it 'allows 5-digit ports when using key servers' do
      expect { Puppet::Type.type(:apt_key).new(
        :id      => '4BD6EC30',
        :server  => 'http://pgp.mit.edu:12345'
      )}.to_not raise_error
    end
  end

  context 'proxy handling' do

    module OpenURI
      @proxy=nil
      def self.open_http(buf, target, proxy, options)
        @proxy=proxy
      end
      def self.get_proxy
        @proxy
      end
    end

    let(:provider) { Puppet::Type.type(:apt_key).new(
        :id => '4BD6EC30',
        :content => 'http://apt.puppetlabs.com/pubkey.gpg'
    ).provider }

    it 'request without proxy' do
      ENV["http_proxy"]=nil
      provider.source_to_file(provider.resource[:content])
      expect(OpenURI.get_proxy).to be_nil
    end

    it 'request with proxy' do
      ENV["http_proxy"]="http://proxy:8080"
      provider.source_to_file(provider.resource[:content])
      proxy=OpenURI.get_proxy
      expect(proxy).to  be_an(Array)
      expect(proxy.size).to eq(3)
      expect(proxy[0]).to be_an(URI)
      expect(proxy[0].host).to eq("proxy")
      expect(proxy[0].port).to eq(8080)
      expect(proxy[1]).to be_nil
      expect(proxy[2]).to be_nil
    end

    it 'request with proxy and authentication' do
      ENV["http_proxy"]="http://user:password@proxy:8080"
      provider.source_to_file(provider.resource[:content])
      proxy=OpenURI.get_proxy
      expect(proxy).to  be_an(Array)
      expect(proxy.size).to eq(3)
      expect(proxy[0]).to be_an(URI)
      expect(proxy[0].host).to eq("proxy")
      expect(proxy[0].port).to eq(8080)
      expect(proxy[1]).to eq("user")
      expect(proxy[2]).to eq("password")
    end

  end
end
