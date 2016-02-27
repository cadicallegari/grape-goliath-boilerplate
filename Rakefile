#!/usr/bin/env rake
require "rubygems"
require "bundler/setup"
require 'goliath'
Bundler.require(:default, Goliath.env)

if Goliath.env?(:test)
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new
  task :default => :spec
  task :test => :spec
end

# to load geocoder in rake tasks
Geocoder::Railtie.insert

StandaloneMigrations::Tasks.load_tasks

require "./config/initializers/locales.rb"
require "./config/initializers/load_path.rb"
require "./config/initializers/activerecord.rb"


I18n.enforce_available_locales = false
I18n.load_path = ['config/locales/pt-BR.yml']
I18n.default_locale = :'pt-BR'

# load rake tasks
Dir["./lib/tasks/*.rb"].each { |f| require f }

namespace :db do
  namespace :test do
    task :prepare => :environment do
      Rake::Task["db:seed"].invoke
    end
  end
end
