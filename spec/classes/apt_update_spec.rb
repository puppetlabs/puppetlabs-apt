# frozen_string_literal: true

require 'spec_helper'

describe 'apt::update', type: :class do
  context "when apt::update['frequency']='always'" do
    {
      'a recent run' => Time.now.to_i,
      'we are due for a run' => 1_406_660_561,
      'the update-success-stamp file does not exist' => -1,
    }.each_pair do |desc, factval|
      context "when $apt_update_last_success indicates #{desc}" do
        let(:facts) do
          {
            os: {
              family: 'Debian',
              name: 'Debian',
              release: {
                major: '9',
                full: '9.0',
              },
              distro: {
                codename: 'stretch',
                id: 'Debian',
              },
            },
            apt_update_last_success: factval,
          }
        end
        let(:pre_condition) do
          "class{'::apt': update => {'frequency' => 'always' },}"
        end

        it 'triggers an apt-get update run' do
          # set the apt_update exec's refreshonly attribute to false
          expect(subject).to contain_exec('apt_update').with('refreshonly' => false)
        end
      end
    end
    context 'when $apt_update_last_success is nil' do
      let(:facts) do
        {
          os: {
            family: 'Debian',
            name: 'Debian',
            release: {
              major: '9',
              full: '9.0',
            },
            distro: {
              codename: 'stretch',
              id: 'Debian',
            },
          },
        }
      end
      let(:pre_condition) { "class{ '::apt': update => {'frequency' => 'always' },}" }

      it 'triggers an apt-get update run' do
        # set the apt_update exec\'s refreshonly attribute to false
        expect(subject).to contain_exec('apt_update').with('refreshonly' => false)
      end
    end

    context 'when Exec[apt_update] refreshonly is overridden to true and has recent run' do
      let(:facts) do
        {
          os: {
            family: 'Debian',
            name: 'Debian',
            release: {
              major: '9',
              full: '9.0',
            },
            distro: {
              codename: 'stretch',
              id: 'Debian',
            },
          },
          apt_update_last_success: Time.now.to_i,
        }
      end
      let(:pre_condition) do
        "
        class{'::apt': update => {'frequency' => 'always' },}
        Exec <| title=='apt_update' |> { refreshonly => true }
        "
      end

      it 'skips an apt-get update run' do
        # set the apt_update exec's refreshonly attribute to false
        expect(subject).to contain_exec('apt_update').with('refreshonly' => true)
      end
    end
  end

  context "when apt::update['frequency']='reluctantly'" do
    {
      'a recent run' => Time.now.to_i,
      'we are due for a run' => 1_406_660_561,
      'the update-success-stamp file does not exist' => -1,
    }.each_pair do |desc, factval|
      context "when $apt_update_last_success indicates #{desc}" do
        let(:facts) do
          {
            os: {
              family: 'Debian',
              name: 'Debian',
              release: {
                major: '9',
                full: '9.0',
              },
              distro: {
                codename: 'stretch',
                id: 'Debian',
              },
            },
            apt_update_last_success: factval,
          }
        end
        let(:pre_condition) { "class{ '::apt': update => {'frequency' => 'reluctantly' },}" }

        it 'does not trigger an apt-get update run' do
          # don't change the apt_update exec's refreshonly attribute. (it should be true)
          expect(subject).to contain_exec('apt_update').with('refreshonly' => true)
        end
      end
    end
    context 'when $apt_update_last_success is nil' do
      let(:facts) do
        {
          os: {
            family: 'Debian',
            name: 'Debian',
            release: {
              major: '9',
              full: '9.0',
            },
            distro: {
              codename: 'stretch',
              id: 'Debian',
            },
          },
        }
      end
      let(:pre_condition) { "class{ '::apt': update => {'frequency' => 'reluctantly' },}" }

      it 'does not trigger an apt-get update run' do
        # don't change the apt_update exec's refreshonly attribute. (it should be true)
        expect(subject).to contain_exec('apt_update').with('refreshonly' => true)
      end
    end
  end

  ['hourly', 'daily', 'weekly', 60].each do |update_frequency|
    context "when apt::update['frequency'] has the value of #{update_frequency}" do
      pair = { 'we are due for a run' => 1_406_660_561, 'the update-success-stamp file does not exist' => -1 }
      pair.each_pair do |desc, factval|
        context "when $apt_update_last_success indicates #{desc}" do
          let(:facts) do
            {
              os: {
                family: 'Debian',
                name: 'Debian',
                release: {
                  major: '9',
                  full: '9.0',
                },
                distro: {
                  codename: 'stretch',
                  id: 'Debian',
                },
              },
              apt_update_last_success: factval,
            }
          end
          let(:pre_condition) { "class{ '::apt': update => {'frequency' => #{update_frequency.inspect},} }" }

          it 'triggers an apt-get update run' do
            # set the apt_update exec\'s refreshonly attribute to false
            expect(subject).to contain_exec('apt_update').with('refreshonly' => false)
          end
        end
      end
      context 'when the $apt_update_last_success fact has a recent value' do
        let(:facts) do
          {
            os: {
              family: 'Debian',
              name: 'Debian',
              release: {
                major: '9',
                full: '9.0',
              },
              distro: {
                codename: 'stretch',
                id: 'Debian',
              },
            },
            apt_update_last_success: Time.now.to_i,
          }
        end
        let(:pre_condition) { "class{ '::apt': update => {'frequency' => #{update_frequency.inspect},} }" }

        it 'does not trigger an apt-get update run' do
          # don't change the apt_update exec\'s refreshonly attribute. (it should be true)
          expect(subject).to contain_exec('apt_update').with('refreshonly' => true)
        end
      end

      context 'when $apt_update_last_success is nil' do
        let(:facts) do
          {
            os: {
              family: 'Debian',
              name: 'Debian',
              release: {
                major: '9',
                full: '9.0',
              },
              distro: {
                codename: 'stretch',
                id: 'Debian',
              },
            },
            apt_update_last_success: nil,
          }
        end
        let(:pre_condition) { "class{ '::apt': update => {'frequency' => #{update_frequency.inspect},} }" }

        it 'triggers an apt-get update run' do
          # set the apt_update exec\'s refreshonly attribute to false
          expect(subject).to contain_exec('apt_update').with('refreshonly' => false)
        end
      end
    end
  end
end
