## ---- SETUP THE DATABASE CONNECTION
if Goliath.env?(:production)
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/dev')
  # puts db.to_yaml
  ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'em_postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
      # :database => 'postgres',
      # :schema_search_path => 'public'
  )
else
  db = YAML.load(File.open('config/database.yml'))[Goliath.env.to_s]
  ActiveRecord::Base.establish_connection(db)
end
