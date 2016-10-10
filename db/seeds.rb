require 'csv'
# require_relative 'environment'
require_relative 'classes'
require_relative 'models/movie'
require_relative 'models/rating'
require_relative 'models/user'
require 'pg'



class MovieData
  def initialize(filename)
    @filename = filename
  end

  def load_from_file
    CSV.foreach(@filename, encoding: 'iso-8859-1', col_sep: '|') do |line|
      movie_id = line[0].to_i
      title = line[1]
      release_date = line[2]
      url = line[3]

      Movie.create(
        id: movie_id,
        title: title,
        release_date: release_date,
        url: url
      )
    end
  end
end

class UserData
  def initialize(filename)
    @filename = filename
  end

  def load_from_file
    CSV.foreach(@filename, encoding: 'iso-8859-1', col_sep: ',') do |line|
      user_id = line[0].to_i
      age = line[1].to_i
      gender = line[2]
      occupation = line[3]
      zipcode = line[4].to_i

      User.create(
        id: user_id,
        age: age,
        gender: gender,
        occupation: occupation,
        zipcode: zipcode
      )
    end
  end
end

class RatingsData
  def initialize(filename)
    @filename = filename
  end

  def load_from_file
    CSV.foreach(@filename, col_sep: "\t") do |line|
      user_id = line[0]
      movie_id = line[1]
      score = line[2]

    Rating.create(
      user_id: user_id,
      movie_id: movie_id,
      score: score
    )
    end
  end
end

def main
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']) # connection_details)

  movie_data = MovieData.new('db/u.item') # , ratings_data

  movie_data.load_from_file

  user_data = UserData.new('db/u.user')

  user_data.load_from_file

  ratings_data = RatingsData.new('db/u.data')

  ratings_data.load_from_file

  ActiveRecord::Base.connection.close

end

main if __FILE__ == $PROGRAM_NAME
