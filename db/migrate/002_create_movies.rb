require 'active_record'

class CreateMovies < ActiveRecord::Migration[5.0]
  def up
    create_table :movies do |t|
      # t.integer :movie_id
      t.string :title
      t.string :release_date
      t.text :url
    end
  end

  def down
    drop_table :movies
  end
end

def main
  action = (ARGV[0] || :up).to_sym
  CreateMovies.migrate(action)
end


main if __FILE__ == $PROGRAM_NAME
