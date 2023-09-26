# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'apt::backports' do
  context 'when using defaults' do
    let(:pp) do
      <<-MANIFEST
        include apt::backports
      MANIFEST
    end

    it 'applies idempotently' do
      [1..5].each do
        idempotent_apply(pp)
        break
      rescue # rubocop:disable Lint/SuppressedException
      end
    end

    it 'provides backports apt sources' do
      run_shell('apt policy | grep --quiet backports')
    end
  end
end
