# frozen_string_literal: true

# run a test task
require 'spec_helper_acceptance'

describe 'apt tasks' do
  describe 'update' do
    it 'updates package lists' do
      result = run_bolt_task('apt', 'action' => 'update')
      expect(result.stdout).to contain(%r{Reading package lists})
    end
  end

  describe 'upgrade' do
    it 'upgrades packages' do
      result = run_bolt_task('apt', 'action' => 'upgrade')
      expect(result.stdout).to contain(%r{\d+ upgraded, \d+ newly installed, \d+ to remove and \d+ not upgraded})
    end
  end

  describe 'dist-upgrade' do
    it 'dist-upgrades packages' do
      result = run_bolt_task('apt', 'action' => 'dist-upgrade')
      expect(result.stdout).to contain(%r{\d+ upgraded, \d+ newly installed, \d+ to remove and \d+ not upgraded})
    end
  end

  describe 'autoremove' do
    it 'autoremoves obsolete packages' do
      result = run_bolt_task('apt', 'action' => 'autoremove')
      expect(result.stdout).to contain(%r{\d+ upgraded, \d+ newly installed, \d+ to remove and \d+ not upgraded})
    end
  end
end
