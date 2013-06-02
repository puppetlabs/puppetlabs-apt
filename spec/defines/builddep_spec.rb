require 'spec_helper'
describe 'apt::builddep', :type => :define do

  let(:title) { 'my_package' }

  describe "should require apt-get update" do
    it { should contain_apt__update("apt-builddep-#{title}")}
  end

end
