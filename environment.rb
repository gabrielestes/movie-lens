require 'active_record'
require 'pg'

configure :development do
  ActiveRecord::Base.establish_connection(
    adapter:  'postgresql', # or 'mysql2' or 'sqlite3'
    host:     'localhost',
    database: 'movielens',
    username: 'Gabriel',
    password: 'HarryPotter'
  )
end
