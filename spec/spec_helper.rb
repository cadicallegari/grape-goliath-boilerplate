# A guide how to write Goliath tests can be found in the link below
# http://www.everburning.com/news/stage-left-enter-goliath/
# and the params usage can be found at
# https://github.com/igrigorik/em-http-request/wiki/Issuing-Requests
require "rubygems"

ENV["RACK_ENV"] ||= 'test'
require 'simplecov'
SimpleCov.start do
  add_filter '/config/'
  add_filter '/db/'
  add_filter '/spec/'
  add_filter '/app.rb'
  add_group 'Endpoints', 'app/api*'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Views', 'app/views'
end


require "rack/test"
require 'goliath/test_helper'
require 'em-synchrony/em-http'
require 'minitest/autorun'
require 'minitest'
require './app'
require 'multi_json'
require 'oj'

require "./config/application.rb"


Goliath.env = :test
RSpec.configure do |c|
  # c.include Goliath::TestHelper, example_group: { file_path: /spec\// }
end


puts "Running specs in #{ENV['RACK_ENV'].capitalize} environment..."

require 'database_cleaner'
RSpec.configure do |config|

  config.add_setting(:clear_tables)
  # config.clear_tables = %w(books)

  config.before(:all) do
    DatabaseCleaner.strategy = :truncation, {only: config.clear_tables}
    DatabaseCleaner.clean_with(:truncation, {only: config.clear_tables})
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
end


# some helper methods for testing stuff
def hash_response_body
  MultiJson.load(last_response.body)
end

def base_headers
  { "CONTENT_TYPE" => "application/json;charset=UTF-8" }
end
