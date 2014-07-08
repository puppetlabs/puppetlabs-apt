require 'spec_helper_acceptance'

describe 'apt::autoproxy define', :unless => UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
  context 'defaults' do
    it 'should work with no errors' do
      pp = <<-EOS
      include apt::autoproxy
      EOS

      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/apt/apt.conf.d/30test') do
      it { should be_file }
      it { should contain 'Acquire::http::ProxyAutoDetect "/usr/share/squid-deb-proxy-client/apt-avahi-discover";' }
    end
  end

end
