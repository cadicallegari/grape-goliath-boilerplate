Dir["./app/decorators/**/*.rb"].each { |f| require f }
Dir["./app/policies/**/*.rb"].each { |f| require f }
Dir["./app/abilities/*.rb"].each { |f| require f }
Dir["./app/queries/**/*.rb"].each { |f| require f }
Dir["./app/parsers/**/*.rb"].each { |f| require f }
Dir["./app/helpers/**/*.rb"].each { |f| require f}
Dir["./app/view_objects/**/*.rb"].each { |f| require f }
Dir["./app/services/**/*.rb"].each { |f| require f }
Dir["./app/presenters/**/*.rb"].each { |f| require f }
Dir["./app/uploaders/*.rb"].each { |f| require f }
Dir["./app/models/**/*.rb"].each { |f| require f }
Dir["./app/workers/*.rb"].each { |f| require f }
