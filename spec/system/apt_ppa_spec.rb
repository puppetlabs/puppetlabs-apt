require 'spec_helper_system'

describe 'apt::ppa' do

  context 'reset' do
    it 'removes ppa' do
      shell('rm /etc/apt/sources.list.d/drizzle-developers-ppa*')
    end
  end

  context 'apt::ppa' do
    it 'should work with no errors' do
      pp = <<-EOS
      include '::apt'
      apt::ppa { 'ppa:drizzle-developers/ppa': }
      EOS

      puppet_apply(pp) do |r|
        r.exit_code.should_not == 1
      end
    end

    describe 'contains the source file' do
      it 'contains a drizzle ppa source' do
        shell('ls /etc/apt/sources.list.d/drizzle-developers-ppa-*.list') do |r|
          r.exit_code.should be_zero
        end
      end
    end
  end

  context 'reset' do
    it 'removes ppa' do
      shell('rm /etc/apt/sources.list.d/drizzle-developers-ppa*')
    end
  end

end
