require 'rubygems'
require 'bundler/setup'
require 'active_record'
require 'pg'
require 'yaml'
require 'rake'


namespace :db do

  desc "Migrate the db"
  task :migrate do
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
    ActiveRecord::Migrator.migrate("db/migrate/")
  end

  desc "Create the db"
  task :create do
    admin_connection = ENV['DATABASE_URL'].merge({'database'=> 'postgres',
    'schema_search_path'=> 'public'})
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.create_database(ENV['DATABASE_URL'].fetch('database'))
  end

  desc "drop the db"
  task :drop do
    admin_connection = ENV['DATABASE_URL'].merge({'database'=> 'postgres',
    'schema_search_path'=> 'public'})
    ActiveRecord::Base.establish_connection(admin_connection)
    ActiveRecord::Base.connection.drop_database(ENV['DATABASE_URL'].fetch('database'))
  end
end
