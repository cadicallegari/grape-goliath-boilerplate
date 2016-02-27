require 'active_support'
require 'active_support/core_ext'
require 'colorize'

module Cleanup
  def Cleanup.remove_dir(relative_path)
    unless Dir.exists?(relative_path)
      puts "      #{'not found'.light_red}  #{relative_path}"
      return false
    end

    if Dir["#{relative_path}/*"].empty?
      puts "      #{'remove'.light_green}  #{relative_path}"
      Dir.unlink(relative_path)
    else
      puts "      #{'not empty'.light_red}  #{relative_path}"
    end
  end
end

class Gen < Thor
  include Cleanup
  include Thor::Actions

  package_name "Gen"
  map "-L" => :list

  def self.source_root
    File.dirname(__FILE__)
  end

  attr_accessor :version, :name

  desc "create_resource <version> <plural_name>", "creates a new resource, associated directories, and mounts it into the API"
  def create_resource(version, name)
    self.version = version
    self.name = name
    puts "    Creating resource `#{name.dup.light_magenta}` for version `#{version.dup.light_magenta}`..."

    # create the api resource file
    template "templates/create_resource.tt", "app/apis/#{version}/#{name.downcase}.rb"

    # create the model
    template "templates/create_model.tt", "app/models/#{name.downcase.singularize}.rb"

    # add a all.rabl to that view directory
    template "templates/create_base_rabl.tt", "app/views/#{version}/#{name.downcase}/all.rabl"

    # add a factory and spec tests
    template "templates/create_factory.tt", "spec/factories/#{version}/#{name.downcase}.rb"

    # add a factory and spec tests
    template "templates/create_spec.tt", "spec/api/#{version}/#{name.downcase}_spec.rb"

    # add a new migration
    now = Time.now.strftime("%Y%m%d%H%M%S")
    template "templates/create_model_migration.tt", "db/migrate/#{now}_create_#{name.downcase}.rb"

    # add a new mount in the API class (api.rb)
    # TODO write code to do this automatically...
    # msg = "Make sure to add a new line `mount API#{version}::#{name.camelize}` to the end of app/api.rb!"
    # puts "      #{msg.light_magenta}"
    # inject_into_file 'app/api.rb', "\n  mount API#{version}::#{name.camelize}", after: "  # -- ENDPOINT MOUNTS --"
  end


  desc "destroy_resource <version> <plural_name>", "destroys the named resource and removes all the things"
  def destroy_resource(version, name)
    self.version = version
    self.name = name
    puts "    Destroying resource `#{name.dup.light_magenta}` on version `#{version.dup.light_magenta}`..."
    remove_file "app/apis/#{version}/#{name.downcase}.rb"
    remove_file "app/models/#{name.downcase.singularize}.rb"
    remove_file "app/views/#{version}/#{name.downcase}/all.rabl"
    remove_file "spec/factories/#{version}/#{name.downcase}.rb"
    remove_file "spec/api/#{version}/#{name.downcase}_spec.rb"
    Dir["db/migrate/*_create_#{name.downcase}.rb"].each { |f| remove_file f }
    puts "      #{'delete'.light_green}  mount API#{version}::#{name.camelize}"
    # gsub_file "app/api.rb", "  mount API#{version}::#{name.camelize}\n", "", verbose: false
    # clean up if necessary
    Cleanup::remove_dir("app/apis/#{version}")
    Cleanup::remove_dir("app/views/#{version}/#{name.downcase}")
    Cleanup::remove_dir("app/views/#{version}")
  end


  desc "create_model <version> <plural_name>", "creates just a model, associated directories"
  def create_model(version, name)
    self.version = version
    self.name = name

    # create the model
    template "templates/create_model.tt", "app/models/#{name.downcase.singularize}.rb"

    # add a all.rabl to that view directory
    template "templates/create_base_rabl.tt", "app/views/#{version}/#{name.downcase}/all.rabl"

    # add a new migration
    now = Time.now.strftime("%Y%m%d%H%M%S")
    template "templates/create_model_migration.tt", "db/migrate/#{now}_create_#{name.downcase}.rb"

    # add a new mount in the API class (api.rb)
    # TODO write code to do this automatically...
    # msg = "Make sure to add a new line `mount API#{version}::#{name.capitalize}` to the end of app/api.rb!"
    # puts "      #{msg.light_magenta}"
    # inject_into_file 'app/api.rb', "\n  mount API#{version}::#{name.capitalize}", after: "  # -- ENDPOINT MOUNTS --"
  end

  desc "destroy_model <version> <plural_name>", "destroys the named model and removes all the things"
  def destroy_model(version, name)
    self.version = version
    self.name = name
    puts "    Destroying model `#{name.dup.light_magenta}` on version `#{version.dup.light_magenta}`..."
    remove_file "app/models/#{name.downcase.singularize}.rb"
    remove_file "app/views/#{version}/#{name.downcase}/all.rabl"
    Dir["db/migrate/*_create_#{name.downcase}.rb"].each { |f| remove_file f }
    # puts "      #{'delete'.light_green}  mount API#{version}::#{name.capitalize}"
    # clean up if necessary
    Cleanup::remove_dir("app/views/#{version}/#{name.downcase}")
    Cleanup::remove_dir("app/views/#{version}")
  end


  desc "create_join_table <version> <name>", "creates just a join table"
  def create_join_table(version, name)
    self.version = version
    self.name = name

    # add a new migration
    now = Time.now.strftime("%Y%m%d%H%M%S")
    template "templates/create_join_table_migration.tt", "db/migrate/#{now}_create_#{name.downcase}_join_table.rb"
  end

  desc "destroy_join_table <version> <name>", "destroys the named join table"
  def destroy_join_table(version, name)
    self.version = version
    self.name = name
    puts "    Destroying join table `#{name.dup.light_magenta}` on version `#{version.dup.light_magenta}`..."
    Dir["db/migrate/*_create_#{name.downcase}_join_table.rb"].each { |f| remove_file f }
  end

end
