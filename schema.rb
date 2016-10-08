require_relative 'environment'
require 'active_record'

class CreateMoviesTable < ActiveRecord::Migration[5.0]
  create_table :movies do |t|
    # t.integer :movie_id
    t.string :title
    t.string :release_date
    t.text :url
  end

  def down
    drop_table :movies
  end
end

class CreateUsersTable < ActiveRecord::Migration[5.0]
  def up
    create_table :users do |t|
      # t.integer :user_id
      t.integer :age
      t.string :gender
      t.string :occupation
      t.integer :zipcode
    end
  end

  def drop
    drop_table :users
  end
end

class CreateRatingsTable < ActiveRecord::Migration[5.0]
  def up
    create_join_table :users, :movies, table_name: :ratings do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :movie, index: true, foreign_key: true
      t.float :score
    end
  end

  def down
    drop_table :ratings
  end
end

def main
  action = (ARGV[0] || :up).to_sym
  CreateMoviesTable.migrate(action)
  CreateUsersTable.migrate(action)
  CreateRatingsTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
