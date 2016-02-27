require "./config/initializers/locales.rb"
require "./config/initializers/activerecord.rb"

# ---- SETUP THE ACTIVERECORD LOGGER
if Goliath.env?(:development)
  log_file = File.open("log/#{Goliath::env}.log", "a+")
  ActiveRecord::Base.logger = Logger.new MultiIO.new(STDOUT, log_file)
end

# ---- CONFIGURE RABL FOR JSON OUTPUT
Rabl.configure do |config|
  # Commented as these are defaults
  # config.cache_all_output = false
  # config.cache_sources = Rails.env != 'development' # Defaults to false
  # config.cache_engine = Rabl::CacheEngine.new # Defaults to Rails cache
  # config.perform_caching = false
  # config.escape_all_output = false
  # config.json_engine = nil # Class with #dump class method (defaults JSON)
  # config.msgpack_engine = nil # Defaults to ::MessagePack
  # config.bson_engine = nil # Defaults to ::BSON
  # config.plist_engine = nil # Defaults to ::Plist::Emit
  config.include_json_root = false
  # config.include_msgpack_root = true
  # config.include_bson_root = true
  # config.include_plist_root = true
  # config.include_xml_root  = false
  config.include_child_root = false
  # config.enable_json_callbacks = false
  # config.xml_options = { :dasherize  => true, :skip_types => false }
  # config.raise_on_missing_attribute = true # Defaults to false
  # config.replace_nil_values_with_empty_strings = true # Defaults to false
  # config.replace_empty_string_values_with_nil_values = true # Defaults to false
  config.exclude_nil_values = true # Defaults to false
  # config.exclude_empty_values_in_collections = true # Defaults to false
  config.view_paths = ['app/views']
end
