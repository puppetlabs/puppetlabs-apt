# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'apt::source with class-level source_format' do
  let(:pp) do
    <<-MANIFEST
      $location = $facts['os']['name'] ? {
        'Debian' => 'http://deb.debian.org/debian',
        default  => 'http://archive.ubuntu.com/ubuntu',
      }
      $repos = $facts['os']['name'] ? {
        'Debian' => 'contrib',
        default  => 'multiverse',
      }

      class { 'apt':
        source_format => 'sources',
      }

      apt::source { 'format_default':
        location => $location,
        repos    => $repos,
      }

      apt::source { 'format_override':
        source_format => 'list',
        location      => $location,
        repos         => $repos,
      }
    MANIFEST
  end

  it 'applies idempotently' do
    expect(retry_on_error_matching { idempotent_apply(pp) }).to be_truthy
  end

  it 'creates a deb822 file for sources inheriting the class default' do
    expect(run_shell('test -f /etc/apt/sources.list.d/format_default.sources && test ! -f /etc/apt/sources.list.d/format_default.list')).to be_truthy
  end

  it 'honours a per-source list override' do
    expect(run_shell('test -f /etc/apt/sources.list.d/format_override.list && test ! -f /etc/apt/sources.list.d/format_override.sources')).to be_truthy
  end
end
