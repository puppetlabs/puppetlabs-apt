# Include hiera configuration

RSpec.configure do |c|
    c.hiera_config = 'spec/fixtures/hiera/hiera.yaml'
end
