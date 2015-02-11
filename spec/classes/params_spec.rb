require 'spec_helper'
describe 'apt::params', :type => :class do
  let(:facts) { { :lsbdistid => 'Debian', :osfamily => 'Debian' } }
  let (:title) { 'my_package' }

  it { should contain_apt__params }

  it "Should not contain any resources" do
    should have_resource_count(0)
  end

  describe "With unknown lsbdistid" do

    let(:facts) { { :lsbdistid => 'CentOS' } }
    let (:title) { 'my_package' }

    it do
      expect {
       is_expected.to compile
      }.to raise_error(/Unsupported lsbdistid/)
    end

  end

  describe "With lsb-release not installed" do
    let(:facts) { { :lsbdistid => '' } }
    let (:title) { 'my_package' }

    it do
      expect {
        is_expected.to compile
      }.to raise_error(/Unable to determine lsbdistid, is lsb-release installed/)
    end
  end

end
