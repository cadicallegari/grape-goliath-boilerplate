require "rubygems"
require "bundler/setup"
require 'goliath'
Bundler.require(:default, Goliath.env)

if Goliath.env?(:test)
  require 'factory_girl'
  FactoryGirl.find_definitions
  puts 'Loaded FactoryGirl factories.'
end

Dir["./config/initializers/*.rb"].each { |f| require f }
Dir["./config/application.rb"].each { |f| require f }

require './app/api'

class Application < Goliath::API
  use Goliath::Rack::Heartbeat              # respond to /status with 200, OK (monitoring, etc)
  use Goliath::Rack::Params                 # parse & merge query and body parameters
  use Goliath::Rack::Render                 # auto-negotiate response format
  use Goliath::Rack::DefaultMimeType        # cleanup accepted media types
  # use Goliath::Rack::Formatters::JSON       # JSON output formatter

  use ::Rack::Deflater
  use ::Rack::Reloader, 0 if Goliath.env?(:development)
  use ::Rack::Config do |env|
    env['api.tilt.root'] = 'app/views'
  end

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
    end
  end

  def response(env)
    ::APP::API.call(env)
  end

end
