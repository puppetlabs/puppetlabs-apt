require 'spec_helper'
describe 'apt::transport_https', :type => :class do
  let(:facts) {
    {
      :lsbdistid       => 'Debian',
      :osfamily        => 'Debian',
      :lsbdistcodename => 'wheezy',
      :puppetversion   => Puppet.version,
    }
  }
  let (:title) { 'my_package' }

  it { is_expected.to contain_apt__transport_https }

  # This only installs two packages
  it 'Should contain two resources' do
    expect(subject.call.resources.size).to eq(2)
  end

  it { is_expected.to contain_package('apt-transport-https') }
  it { is_expected.to contain_package('ca-certificates') }

  context 'invalid ensure' do
    let(:params) do
      {
        :ensure => true
      }
    end
    it do
      expect {
        subject.call
      }.to raise_error(Puppet::Error, /ensure must be either present, absent, purged, held, or latest/)
    end
  end
end
