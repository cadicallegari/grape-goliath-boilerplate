source 'http://rubygems.org'
ruby "2.2.3"

gem 'io-console'

# Database things
gem 'pg'
gem 'activerecord', '~> 4.2'
gem 'em-postgresql-adapter', :git => 'git://github.com/cadicallegari/em-postgresql-adapter.git'
gem 'rack-fiber_pool'

# Use EventMachine and Goliath
# for asynchronous HTTP serving
gem 'em-synchrony',  "1.0.3" # because the bug
gem 'rb-readline'
gem 'em-http-request', :git => 'https://github.com/igrigorik/em-http-request.git'
gem 'goliath',         :git => 'https://github.com/postrank-labs/goliath.git'

gem 'rack-ssl-enforcer'

gem 'bcrypt-ruby', '~> 3.0.0'

# Fast JSON de/serialization
gem 'multi_json'
gem 'oj'

# for building json responses
gem 'rabl'

# API builder framework
gem 'grape'
gem 'grape-rabl'

# for performance monitoring
# gem 'newrelic_rpm'
# gem 'newrelic-grape'

# for dev and deploy
gem 'standalone_migrations'#, '~> 2.1'

# for soft delete
# gem "paranoia", "~> 1.0"

# to translate
gem 'i18n'

# to paginate resources
gem 'grape-kaminari'

# to send messages to mobile devices
# gem 'pushmeup'

# use redis for token store
# gem "hiredis"
# gem "redis", :require => ["redis/connection/hiredis", "redis"]

# to fileuploads
# do not forget to install imagemagick
# to fileuploads
# do not forget to install imagemagick
# gem 'carrierwave', :require => %w(carrierwave carrierwave/orm/activerecord)
# gem 'mini_magick'
# gem 'fog', '~> 1.0.0' # Need to specify version, as carrierwave references older (0.9.0) which doesn't allow configuration of Rackspace UK Auth URL

# to parse
gem 'actionpack'

# to validate dates
# gem 'validates_overlap'
# gem 'validates_timeliness'

# generate our tokens
gem 'uuid'

# for get coords
gem 'geocoder'

gem 'racksh'

# for debugging
gem 'pry'

# for custom generators
gem 'thor'
gem 'colorize'

# for tasks
# gem 'sidekiq'
# gem 'sidetiq'
# gem 'sinatra', require: false

# for rerun
gem 'rerun'

# for deploy awesome
gem 'foreman'
gem 'foreman-export-initscript'

gem 'rack-cors', require: 'rack/cors'

# gem 'rails_log_stdout'
gem 'rails_12factor'

gem 'grape_logging'

gem 'email_validator'

# gem 'cancancan', '~> 1.10'
# gem 'grape-cancan'

group :development do
  # gem 'filewatcher'
  # gem 'shotgun'
  # gem 'grape-swagger'
  # gem 'grape-swagger-ui'
  gem "bullet"
  gem 'rubocop', require: false
end

group :test do
  gem 'turn'
  gem 'minitest'
  # for testing
  gem 'rake'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'factory_girl', "~> 4.0"
  gem 'database_cleaner'
  gem "shoulda-matchers"
end
