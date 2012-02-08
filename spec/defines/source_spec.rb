require 'spec_helper'
describe 'apt::source', :type => :define do
  let :title do
    'my_source'
  end

  let :default_params do
    {
      :location           => '',
      :release            => 'karmic',
      :repos              => 'main',
      :include_src        => true,
      :required_packages  => false,
      :key                => false,
      :key_server         => 'keyserver.ubuntu.com',
      :pin                => false,
      :key_content        => false
    }
  end

  [{},
   {
      :location           => 'somewhere',
      :release            => 'precise',
      :repos              => 'security',
      :include_src        => false,
      :required_packages  => 'apache',
      :key                => 'key_name',
      :key_server         => 'keyserver.debian.com',
      :pin                => '600',
      :key_content        => 'ABCD1234'
    }
  ].each do |param_set|
    describe "when #{param_set == {} ? "using default" : "specifying"} class parameters" do
      let :param_hash do
        default_params.merge(param_set)
      end

      let :params do
        param_set
      end

      let :filename do
        "/etc/apt/sources.list.d/#{title}.list"
      end

      let :content do
        content = "# #{title}"
        content << "\ndeb #{param_hash[:location]} #{param_hash[:release]} #{param_hash[:repos]}\n"
        if param_hash[:include_src]
          content << "deb-src #{param_hash[:location]} #{param_hash[:release]} #{param_hash[:repos]}\n"
        end
        content
      end

      it { should contain_apt__params }

      it { should contain_file("#{title}.list").with({
          'path' => filename,
          'ensure' => "file",
          'owner'   => "root",
          'group'     => "root",
          'mode'      => 644,
          'content'   => content
        })
      }

      it {
        if param_hash[:pin]
          should contain_apt__pin(param_hash[:release]).with({
            "priority"  => param_hash[:pin],
            "before"    => "File[#{title}.list]"
          })
        else
          should_not contain_apt__pin(param_hash[:release]).with({
            "priority"  => param_hash[:pin],
            "before"    => "File[#{title}.list]"
          })
        end
      }

      it {
        should contain_exec("#{title} apt update").with({
          "command"     => "/usr/bin/apt-get update",
          "subscribe"   => "File[#{title}.list]",
          "refreshonly" => true
        })
      }

      it {
        if param_hash[:required_packages]
          should contain_exec("/usr/bin/apt-get -y install #{param_hash[:required_packages]}").with({
            "subscribe"   => "File[#{title}.list]",
            "refreshonly" => true
          })
        else
          should_not contain_exec("/usr/bin/apt-get -y install #{param_hash[:required_packages]}").with({
            "subscribe"   => "File[#{title}.list]",
            "refreshonly" => true
          })
        end
      }

      it {
        if param_hash[:key]
          if param_hash[:key_content]
            should contain_exec("Add key: #{param_hash[:key]} from content").with({
              "command" => "/bin/echo '#{param_hash[:key_content]}' | /usr/bin/apt-key add -",
              "unless"  => "/usr/bin/apt-key list | /bin/grep '#{param_hash[:key]}'",
              "before"  => "File[#{title}.list]"
            })
            should_not contain_exec("/usr/bin/apt-key adv --keyserver #{param_hash[:key_server]} --recv-keys #{param_hash[:key]}").with({
              "unless"  => "/usr/bin/apt-key list | /bin/grep #{param_hash[:key]}",
              "before"  => "File[#{title}.list]"
            })

          else
            should contain_exec("/usr/bin/apt-key adv --keyserver #{param_hash[:key_server]} --recv-keys #{param_hash[:key]}").with({
                "unless"  => "/usr/bin/apt-key list | /bin/grep #{param_hash[:key]}",
                "before"  => "File[#{title}.list]"
              })
            should_not contain_exec("Add key: #{param_hash[:key]} from content").with({
                "command" => "/bin/echo '#{param_hash[:key_content]}' | /usr/bin/apt-key add -",
                "unless"  => "/usr/bin/apt-key list | /bin/grep '#{param_hash[:key]}'",
                "before"  => "File[#{title}.list]"
              })
          end
        else
          should_not contain_exec("Add key: #{param_hash[:key]} from content").with({
            "command"   => "/bin/echo '#{param_hash[:key_content]}' | /usr/bin/apt-key add -",
            "unless"    => "/usr/bin/apt-key list | /bin/grep '#{param_hash[:key]}'",
            "before"    => "File[#{title}.list]"
          })
          should_not contain_exec("/usr/bin/apt-key adv --keyserver #{param_hash[:key_server]} --recv-keys #{param_hash[:key]}").with({
              "unless"  => "/usr/bin/apt-key list | /bin/grep #{param_hash[:key]}",
              "before"  => "File[#{title}.list]"
          })

        end
      }
    end
  end
end

