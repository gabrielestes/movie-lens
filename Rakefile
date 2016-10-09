require 'rubygems'
require 'bundler/setup'
require 'active_record'
require 'pg'
require 'yaml'
require 'rake'

namespace :db do

 desc "Migrate the db"
 task :migrate do
   connection_details = YAML::load(File.open('config/database.yml'))
   ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']) # connection_details)
   ActiveRecord::Migrator.migrate("db/migrate/")
 end
end
