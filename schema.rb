require_relative 'environment'
require 'active_record'

class CreateMoviesTable < ActiveRecord::Migration[5.0]

class CreateUsersTable < ActiveRecord::Migration[5.0]

class CreateRatingsTable < ActiveRecord::Migration[5.0]

def main
  action = (ARGV[0] || :up).to_sym
    CreateMoviesTable.migrate(action)
    CreateUsersTable.migrate(action)
    CreateRatingsTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
