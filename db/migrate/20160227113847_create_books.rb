# need to require this stuff so we can play with AR models in the migration
require 'goliath/goliath'
require 'goliath/runner'
require 'goliath/rack'
Dir["./app/models/*.rb"].each { |f| require f }



class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books, id: :uuid do |t|
      t.string  :title
      t.integer :number_of_pages

      t.timestamps null: false
    end
  end

end
