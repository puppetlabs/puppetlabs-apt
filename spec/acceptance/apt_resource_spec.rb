# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'apt resources' do
  # Verify list-format source parameters produce the expected named source entry.
  it 'writes list-format source options to the named file' do
    pp = <<-MANIFEST
      apt::source { 'acceptance-list':
        location      => 'https://example.invalid/debian',
        release       => 'stable',
        repos         => 'main',
        architecture  => 'amd64',
        allow_unsigned => true,
        notify_update => false,
      }
    MANIFEST

    expect(retry_on_error_matching { idempotent_apply(pp) }).to be_truthy
    expect(run_shell("grep -F 'deb [arch=amd64 trusted=yes] https://example.invalid/debian stable main' /etc/apt/sources.list.d/acceptance-list.list")).to be_truthy
  end

  # Verify deb822 output, enabled state, and ensure-absent cleanup.
  it 'manages a deb822 source lifecycle' do
    present_pp = <<-MANIFEST
      apt::source { 'acceptance-deb822':
        source_format => 'sources',
        location      => ['https://example.invalid/debian'],
        release       => ['stable'],
        repos         => ['main', 'contrib'],
        types         => ['deb', 'deb-src'],
        enabled       => false,
        notify_update => false,
      }
    MANIFEST
    absent_pp = <<-MANIFEST
      apt::source { 'acceptance-deb822':
        source_format => 'sources',
        ensure        => absent,
        notify_update => false,
      }
    MANIFEST

    expect(retry_on_error_matching { idempotent_apply(present_pp) }).to be_truthy
    expect(run_shell("grep -F 'Enabled: no' /etc/apt/sources.list.d/acceptance-deb822.sources")).to be_truthy
    expect(run_shell("grep -F 'Types: deb deb-src' /etc/apt/sources.list.d/acceptance-deb822.sources")).to be_truthy
    expect(apply_manifest(absent_pp, catch_failures: true)).to be_truthy
    expect(run_shell('test ! -e /etc/apt/sources.list.d/acceptance-deb822.sources')).to be_truthy
  end

  # Verify pin priorities and removal are reflected in APT preference files.
  it 'manages pin priority and removal' do
    present_pp = <<-MANIFEST
      apt::pin { 'acceptance-priority':
        packages => ['bash', 'curl'],
        origin   => 'example.invalid',
        priority => 990,
      }
    MANIFEST
    absent_pp = <<-MANIFEST
      apt::pin { 'acceptance-priority':
        ensure => absent,
      }
    MANIFEST

    expect(retry_on_error_matching { idempotent_apply(present_pp) }).to be_truthy
    expect(run_shell("grep -F 'Package: bash curl' /etc/apt/preferences.d/50acceptance-priority.pref")).to be_truthy
    expect(run_shell("grep -F 'Pin-Priority: 990' /etc/apt/preferences.d/50acceptance-priority.pref")).to be_truthy
    expect(apply_manifest(absent_pp, catch_failures: true)).to be_truthy
    expect(run_shell('test ! -e /etc/apt/preferences.d/50acceptance-priority.pref')).to be_truthy
  end

  # Verify apt::conf maps priorities and ensure-absent to apt.conf.d files.
  it 'manages apt configuration files' do
    present_pp = <<-MANIFEST
      apt::conf { 'acceptance':
        content       => 'Acquire::Retries "2";',
        priority      => 42,
        notify_update => false,
      }
    MANIFEST
    absent_pp = <<-MANIFEST
      apt::conf { 'acceptance':
        ensure        => absent,
        notify_update => false,
      }
    MANIFEST

    expect(retry_on_error_matching { idempotent_apply(present_pp) }).to be_truthy
    expect(run_shell("grep -F 'Acquire::Retries \"2\";' /etc/apt/apt.conf.d/42acceptance")).to be_truthy
    expect(apply_manifest(absent_pp, catch_failures: true)).to be_truthy
    expect(run_shell('test ! -e /etc/apt/apt.conf.d/42acceptance')).to be_truthy
  end

  # Verify direct apt::setting resources honor file priority and removal.
  it 'manages direct apt settings' do
    present_pp = <<-MANIFEST
      apt::setting { 'conf-acceptance-setting':
        ensure        => present,
        priority      => 43,
        content       => 'Acquire::Retries "3";',
        notify_update => false,
      }
    MANIFEST
    absent_pp = <<-MANIFEST
      apt::setting { 'conf-acceptance-setting':
        ensure        => absent,
        notify_update => false,
      }
    MANIFEST

    expect(retry_on_error_matching { idempotent_apply(present_pp) }).to be_truthy
    expect(run_shell("grep -F 'Acquire::Retries \"3\";' /etc/apt/apt.conf.d/43acceptance-setting")).to be_truthy
    expect(apply_manifest(absent_pp, catch_failures: true)).to be_truthy
    expect(run_shell('test ! -e /etc/apt/apt.conf.d/43acceptance-setting')).to be_truthy
  end

  # Verify auth credentials use restrictive permissions and can be removed.
  it 'manages authentication configuration securely' do
    present_pp = <<-MANIFEST
      apt::auth { 'acceptance-auth':
        machine  => 'packages.example.invalid',
        login    => 'acceptance-user',
        password => 'fake-acceptance-credential',
      }
    MANIFEST
    absent_pp = <<-MANIFEST
      apt::auth { 'acceptance-auth':
        ensure => absent,
      }
    MANIFEST

    expect(retry_on_error_matching { idempotent_apply(present_pp) }).to be_truthy
    expect(run_shell("grep -F 'machine packages.example.invalid' /etc/apt/auth.conf.d/acceptance-auth.conf")).to be_truthy
    expect(run_shell('test "$(stat -c %a /etc/apt/auth.conf.d/acceptance-auth.conf)" = 600')).to be_truthy
    expect(apply_manifest(absent_pp, catch_failures: true)).to be_truthy
    expect(run_shell('test ! -e /etc/apt/auth.conf.d/acceptance-auth.conf')).to be_truthy
  end

  # Verify apt-mark hold and unhold actions alter the package selection state.
  it 'holds and unholds an installed package' do
    hold_pp = <<-MANIFEST
      apt::mark { 'bash':
        setting => 'hold',
      }
    MANIFEST
    unhold_pp = <<-MANIFEST
      apt::mark { 'bash':
        setting => 'unhold',
      }
    MANIFEST

    expect(apply_manifest(hold_pp, catch_failures: true)).to be_truthy
    expect(run_shell("apt-mark showhold | grep -Fx 'bash'")).to be_truthy
    expect(apply_manifest(unhold_pp, catch_failures: true)).to be_truthy
    expect(run_shell("! apt-mark showhold | grep -Fx 'bash'")).to be_truthy
  end
end
