# need to require this stuff so we can play with AR models in the migration
require 'goliath/goliath'
require 'goliath/runner'
require 'goliath/rack'
Dir["./app/models/*.rb"].each { |f| require f }

class EnableUuidExtension < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
  end
end
