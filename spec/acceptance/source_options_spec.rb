# frozen_string_literal: true

require 'spec_helper_acceptance'

# Keep each complete repository lifecycle in one example, including its cleanup.
# rubocop:disable RSpec/ExampleLength
describe 'advanced apt::source options' do
  fixture = '/var/lib/apt-source-options-acceptance'

  before(:all) do
    # A signed, entirely local archive makes APT verify both the source syntax and its trust selectors.
    run_shell(<<~SHELL)
      set -eu
      mkdir -p #{fixture}/gnupg #{fixture}/lists/partial
      chmod 700 #{fixture}/gnupg
      gpg --homedir #{fixture}/gnupg --batch --pinentry-mode loopback --passphrase '' \
        --quick-generate-key 'APT source options fixture' rsa2048 sign 0
      gpg --homedir #{fixture}/gnupg --batch --export > #{fixture}/archive.gpg
      gpg --homedir #{fixture}/gnupg --batch --armor --export > #{fixture}/archive.asc
      gpg --homedir #{fixture}/gnupg --with-colons --list-keys | awk -F: '$1 == "fpr" { print $10; exit }' > #{fixture}/fingerprint
      mkdir -p #{fixture}/repo/dists/stable/main/binary-amd64 #{fixture}/repo/dists/stable/main/binary-arm64
      for arch in amd64 arm64; do
        printf 'Package: apt-source-options-fixture\\nVersion: 1.0\\nArchitecture: %s\\nMaintainer: Fixture <fixture@example.invalid>\\nDescription: Local acceptance fixture\\nFilename: pool/fixture.deb\\nSize: 1\\nSHA256: %064d\\n\\n' "$arch" 0 \
          > #{fixture}/repo/dists/stable/main/binary-"$arch"/Packages
      done
      cd #{fixture}/repo/dists/stable
      {
        printf 'Origin: AptSourceOptionsFixture\\nLabel: AptSourceOptionsFixture\\nSuite: stable\\nCodename: stable\\nArchitectures: amd64 arm64\\nComponents: main\\n'
        printf 'Date: %s\\nSHA256:\\n' "$(LC_ALL=C date -Ru)"
        for index in main/binary-*/Packages; do
          printf ' %s %s %s\\n' "$(sha256sum "$index" | cut -d' ' -f1)" "$(wc -c < "$index")" "$index"
        done
      } > Release
      gpg --homedir #{fixture}/gnupg --batch --yes --pinentry-mode loopback --passphrase '' --clearsign --output InRelease Release
      chmod -R a+rX #{fixture}/repo
    SHELL
  end

  after(:all) do
    run_shell("rm -rf #{fixture}")
  end

  ['list', 'sources'].product([false, true]).each do |format, multiple|
    it "authenticates a local archive with #{multiple ? 'multiple signers' : 'one keyring'} and manages the #{format} lifecycle", :aggregate_failures do
      if multiple
        supported = run_shell("if dpkg --compare-versions \"$(dpkg-query -W -f='${Version}' apt)\" ge 1.8; then echo yes; else echo no; fi").stdout.strip
        skip 'Multiple keyrings and exact fingerprint selectors require APT >= 1.8' unless supported == 'yes'
      end
      fingerprint = run_shell("cat #{fixture}/fingerprint").stdout.strip
      signers = multiple ? "['#{fixture}/archive.gpg', '#{fixture}/archive.asc', '#{fingerprint}!']" : "'#{fixture}/archive.gpg'"
      manifest = <<~MANIFEST
        apt::source { 'acceptance-advanced':
          source_format               => '#{format}',
          location                    => 'file:#{fixture}/repo',
          release                     => 'stable',
          architecture                => ['amd64', 'i386'],
          architecture_add            => ['arm64'],
          architecture_remove         => ['i386'],
          valid_until_min             => 0,
          valid_until_max             => 3600,
          check_date                  => true,
          date_max_future             => 10,
          by_hash                     => 'no',
          pdiffs                      => false,
          targets                     => ['Packages'],
          targets_add                 => ['Packages'],
          targets_remove              => ['Translations'],
          languages                   => ['none'],
          languages_add               => ['en'],
          languages_remove            => ['en'],
          signed_by                   => #{signers},
          notify_update               => false,
        }
      MANIFEST
      absent = <<~MANIFEST
        apt::source { 'acceptance-advanced':
          source_format => '#{format}',
          ensure        => absent,
          notify_update => false,
        }
      MANIFEST
      apt_options = "-o Dir::Etc::sourcelist=/etc/apt/sources.list.d/acceptance-advanced.#{format} " \
                    "-o Dir::Etc::sourceparts=- -o Dir::State::lists=#{fixture}/lists " \
                    '-o APT::Architecture=amd64 -o Acquire::Languages=none'

      begin
        idempotent_apply(manifest)
        run_shell("apt-get #{apt_options} update")
        targets = run_shell("apt-get #{apt_options} indextargets --format '$(ARCHITECTURE) $(IDENTIFIER)'").stdout
        expect(targets).to include('amd64 Packages', 'arm64 Packages')
        expect(targets).not_to include('i386', 'Translations')
        expect(run_shell("apt-cache #{apt_options} policy apt-source-options-fixture").stdout).to include('1.0')
      ensure
        idempotent_apply(absent)
        run_shell("test ! -e /etc/apt/sources.list.d/acceptance-advanced.#{format}")
        run_shell("find #{fixture}/lists -maxdepth 1 -type f -delete")
      end
    end
  end

  ['list', 'sources'].each do |format|
    it "rejects incompatible #{format} signers on APT before 1.8" do
      supported = run_shell("if dpkg --compare-versions \"$(dpkg-query -W -f='${Version}' apt)\" lt 1.8; then echo yes; else echo no; fi").stdout.strip
      skip 'This check requires APT < 1.8' unless supported == 'yes'

      fingerprint = run_shell("cat #{fixture}/fingerprint").stdout.strip
      ["['#{fixture}/archive.gpg', '#{fixture}/archive.asc']", "['#{fixture}/archive.gpg', '#{fingerprint}']", "'#{fingerprint}!'"].each do |signers|
        manifest = <<~MANIFEST
          apt::source { 'acceptance-incompatible':
            source_format => '#{format}',
            location      => 'file:#{fixture}/repo',
            release       => 'stable',
            signed_by     => #{signers},
            notify_update => false,
          }
        MANIFEST
        apply_manifest(manifest, expect_failures: true) do |result|
          expect(result.stderr).to include('requires APT >= 1.8')
        end
        run_shell("test ! -e /etc/apt/sources.list.d/acceptance-incompatible.#{format}")
      end
    end
  end

  it 'authenticates an inline deb822 public key with APT 2.4 or newer' do
    supported = run_shell("if dpkg --compare-versions \"$(dpkg-query -W -f='${Version}' apt)\" ge 2.4; then echo yes; else echo no; fi").stdout.strip
    skip 'Inline public keys require APT >= 2.4' unless supported == 'yes'

    public_key = run_shell("cat #{fixture}/archive.asc").stdout
    manifest = <<~MANIFEST
      apt::source { 'acceptance-inline':
        source_format => 'sources',
        location      => ['file:#{fixture}/repo'],
        release       => ['stable'],
        architecture  => ['amd64'],
        languages     => ['none'],
        signed_by     => '#{public_key}',
        notify_update => false,
      }
    MANIFEST
    absent = <<~MANIFEST
      apt::source { 'acceptance-inline':
        source_format => 'sources',
        ensure        => absent,
        notify_update => false,
      }
    MANIFEST
    begin
      idempotent_apply(manifest)
      run_shell('apt-get -o Dir::Etc::sourcelist=/etc/apt/sources.list.d/acceptance-inline.sources ' \
                "-o Dir::Etc::sourceparts=- -o Dir::State::lists=#{fixture}/lists -o APT::Architecture=amd64 update")
    ensure
      idempotent_apply(absent)
      run_shell('test ! -e /etc/apt/sources.list.d/acceptance-inline.sources')
    end
    # rubocop:enable RSpec/ExampleLength
  end
end
