# frozen_string_literal: true

require 'spec_helper'

describe 'apt::source' do
  let(:title) { 'advanced' }
  let(:facts) do
    {
      os: {
        family: 'Debian', name: 'Debian',
        release: { major: '12', full: '12.0' },
        distro: { codename: 'bookworm', id: 'Debian' }
      },
    }
  end

  options = {
    architecture_add: [['aarch64', 'i386'], 'arch+', 'Architectures-Add', ['arm64', 'i386']],
    architecture_remove: [['mips', 'mipsel'], 'arch-', 'Architectures-Remove', ['mips', 'mipsel']],
    valid_until_min: [0, 'valid-until-min', 'Valid-Until-Min', '0'],
    valid_until_max: [3600, 'valid-until-max', 'Valid-Until-Max', '3600'],
    check_date: [false, 'check-date', 'Check-Date', 'no'],
    date_max_future: [0, 'date-max-future', 'Date-Max-Future', '0'],
    by_hash: ['force', 'by-hash', 'By-Hash', 'force'],
    pdiffs: [true, 'pdiffs', 'PDiffs', 'yes'],
    targets: [['Packages', 'Sources'], 'target', 'Targets', ['Packages', 'Sources']],
    targets_add: [['Translations', 'DEP-11'], 'target+', 'Targets-Add', ['Translations', 'DEP-11']],
    targets_remove: [['Contents-deb'], 'target-', 'Targets-Remove', ['Contents-deb']],
    languages: [['en', 'de_DE'], 'lang', 'Languages', ['en', 'de_DE']],
    languages_add: [['fr'], 'lang+', 'Languages-Add', ['fr']],
    languages_remove: [['it'], 'lang-', 'Languages-Remove', ['it']],
    snapshot: ['20250101T000000Z', 'snapshot', 'Snapshot', '20250101T000000Z'],
    allow_weak: [false, 'allow-weak', 'Allow-Weak', 'no'],
    allow_downgrade_to_insecure: [false, 'allow-downgrade-to-insecure', 'Allow-Downgrade-To-Insecure', 'no'],
  }
  fingerprint = '0123456789ABCDEF0123456789ABCDEF01234567'
  public_key = "-----BEGIN PGP PUBLIC KEY BLOCK-----\n\nYWJj\n=abcd\n-----END PGP PUBLIC KEY BLOCK-----\n"
  boolean_options = [:check_date, :pdiffs, :allow_weak, :allow_downgrade_to_insecure]
  boolean_values = [true, false]
  hash_values = ['yes', 'no', 'force']
  snapshot_values = ['yes', 'no', 'enable', 'disable']

  ['list', 'sources'].each do |format|
    context "with #{format} format" do
      let(:params) do
        {
          source_format: format, location: 'file:/srv/apt', release: 'stable',
          notify_update: false
        }
      end
      let(:content) { catalogue.resource('apt::setting', "#{format}-advanced")[:content] }

      it 'does not emit advanced options or change security defaults by default' do
        expect(content).not_to match(%r{Architectures-Add|arch\+=|valid-until|check-date|by-hash|pdiffs|snapshot|allow-weak|allow-downgrade|signed-by}i)
      end

      context 'with all advanced options' do
        let(:params) { super().merge(options.transform_values(&:first)) }

        options.each_value do |_, list_name, deb822_name, rendered|
          it "renders #{deb822_name}" do
            prefix = (format == 'list') ? "#{list_name}=" : "#{deb822_name}: "
            separator = (format == 'list') ? ',' : ' '
            expect(content).to include("#{prefix}#{Array(rendered).join(separator)}")
          end
        end
      end

      boolean_options.each do |param|
        boolean_values.each do |value|
          context "with #{param} #{value}" do
            let(:params) { super().merge(param => value) }

            it 'preserves explicit boolean choices' do
              definition = options.fetch(param)
              rendered = value ? 'yes' : 'no'
              expected = (format == 'list') ? "#{definition[1]}=#{rendered}" : "#{definition[2]}: #{rendered}"
              expect(content).to include(expected)
            end
          end
        end
      end

      hash_values.each do |value|
        context "with by_hash #{value}" do
          let(:params) { super().merge(by_hash: value) }

          it { is_expected.to compile }
        end
      end

      snapshot_values.each do |value|
        context "with snapshot #{value}" do
          let(:params) { super().merge(snapshot: value) }

          it { is_expected.to compile }
        end
      end

      [
        '/etc/apt/keyrings/archive.gpg',
        fingerprint,
        "#{fingerprint}!",
        ['/etc/apt/keyrings/one.gpg', '/etc/apt/keyrings/two.asc', "#{fingerprint}!"],
      ].each do |signers|
        context "with signed_by #{signers.inspect}" do
          let(:params) { super().merge(signed_by: signers) }

          it 'renders keyring paths and full fingerprint selectors' do
            expected = (format == 'list') ? "signed-by=#{Array(signers).join(',')}" : "Signed-By: #{Array(signers).join(' ')}"
            expect(content).to include(expected)
          end
        end
      end

      context 'with an inline key' do
        let(:params) { super().merge(signed_by: public_key) }

        if format == 'sources'
          it 'indents the entire key and encodes blank lines with a dot', :aggregate_failures do
            expect(content).to include("Signed-By:\n -----BEGIN PGP PUBLIC KEY BLOCK-----\n .\n YWJj\n =abcd\n -----END PGP PUBLIC KEY BLOCK-----\n")
            expect(content).not_to include("\n\n")
          end

          if format == 'sources'
            context 'with inline armor headers, multiple blank lines and no trailing newline' do
              let(:params) do
                key = public_key.sub("BLOCK-----\n\n", "BLOCK-----\nVersion: Fixture (test)\nComment: public@example.invalid & friends\n\n\n").chomp
                super().merge(signed_by: key)
              end

              it 'preserves headers and all blank continuation lines', :aggregate_failures do
                expect(content).to include(" Version: Fixture (test)\n Comment: public@example.invalid & friends\n .\n .\n YWJj\n")
                expect(content).to end_with(" -----END PGP PUBLIC KEY BLOCK-----\n")
              end
            end
          end
        else
          it { is_expected.to compile.and_raise_error(%r{inline signed_by public keys require deb822}) }
        end
      end

      { key: fingerprint, keyring: '/etc/apt/keyrings/legacy.gpg' }.each do |param, value|
        context "with signed_by and #{param}" do
          let(:params) { super().merge(signed_by: fingerprint, param => value) }

          it { is_expected.to compile.and_raise_error(%r{mutually exclusive}) }
        end
      end

      invalid = [
        { architecture_add: [] }, { architecture_remove: [] }, { architecture: [] },
        { architecture_add: ['amd64', 'aarch64'], architecture_remove: ['arm64'] },
        { architecture_add: ['amd64'], architecture_remove: ['amd64'] },
        { architecture_add: 'amd64' }, { architecture_add: ["amd64\nTrusted: yes"] },
        { architecture: 'amd64 trusted=yes' }, { architecture: 'amd64,,arm64' },
        { by_hash: true }, { by_hash: 'always' },
        { pdiffs: 'yes' }, { check_date: 'no' }, { allow_weak: 'yes' },
        { allow_downgrade_to_insecure: 'yes' },
        { targets: [] }, { targets_add: [] }, { targets_remove: [] },
        { languages: [] }, { languages_add: [] }, { languages_remove: [] },
        { targets: ['Packages,Translations'] }, { languages: ['en de'] },
        { targets: ["Packages\nTrusted: yes"] }, { languages: ["en\rTrusted: yes"] },
        { snapshot: 'yesterday' }, { snapshot: "yes\nTrusted: yes" },
        { valid_until_min: -1 }, { valid_until_max: -1 }, { date_max_future: -1 },
        { valid_until_min: '0' }, { valid_until_max: 1.5 }, { date_max_future: false },
        { valid_until_min: 2, valid_until_max: 1 },
        { signed_by: [] }, { signed_by: 'relative.gpg' }, { signed_by: 'DEADBEEF' },
        { signed_by: "#{fingerprint}!!" }, { signed_by: ['/etc/one.gpg', public_key] },
        { signed_by: "/etc/one.gpg\nTrusted: yes" }, { signed_by: '/etc/a.gpg trusted=yes' },
        { signed_by: "/etc/one.gpg,#{fingerprint}" }, { signed_by: '/etc/a]trusted=yes' },
        { signed_by: "#{public_key}\nTrusted: yes" },
        { signed_by: "-----BEGIN PGP PRIVATE KEY BLOCK-----\nYWJj\n-----END PGP PRIVATE KEY BLOCK-----" },
        { comment: "comment\nTrusted: yes" }, { location: "file:/srv/apt\nTrusted: yes" },
        { repos: "main\nTrusted: yes" }, { release: "stable\rTrusted: yes" },
        { keyring: "/etc/one.gpg\nTrusted: yes" }
      ]
      invalid.each do |values|
        context "with invalid #{values.inspect}" do
          let(:params) { super().merge(values) }

          it { is_expected.not_to compile }
        end
      end

      context 'with an unlimited maximum validity' do
        let(:params) { super().merge(valid_until_min: 60, valid_until_max: 0) }

        it { is_expected.to compile }
      end

      context 'with an architecture array' do
        let(:params) { super().merge(architecture: ['amd64', 'arm64']) }

        it 'uses the appropriate separator' do
          expect(content).to include((format == 'list') ? 'arch=amd64,arm64' : 'Architectures: amd64 arm64')
        end
      end
    end
  end
end
