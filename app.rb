require 'sinatra'
require 'active_record'
require_relative 'models/user'
require_relative 'models/movie'
require_relative 'models/rating'
require 'json'
require 'pg'
# require_relative 'environment'
# require 'sinatra/cross_origin'

database_config = YAML::load(File.open('config/database.yml'))

before do
  ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  content_type :json
end

after do
  ActiveRecord::Base.connection.close
end

get '/api/movies' do
  title = params['title']
  release_date = params['release_date']
  url = params['url']

  if !title.nil?
    movies = Movie.where(title: title, release_date: release_date, url: url)
  else
    movies = Movie.all.order(title: :DESC)
  end

  movies.to_json
end

get '/api/movie' do
  movie = Movie.select(:id, :title).where("title LIKE ?", "%#{params['search']}%").first
  movie.get_average_rating
  movie.to_json
end

post '/api/movie/new' do
  title = params['title']
  release_date = params['release_date']
  url = params['url']

  movie = Movie.new(title: title, release_date: release_date, url: url)
  if movie.save
    movie.to_json
  else
    error 500
  end
end

post '/api/rate' do # write new review
  score = params['score']
  movie_id = params['movie_id']
  user_id = params['user_id']

  rating = Rating.new(score: score, movie_id: movie_id, user_id: user_id)
  if rating.save
    rating.to_json
  else
    error 500
  end
end

delete 'api/user/:id' do |id|
  user = User.delete(params[id])
  redirect_to('api/movies')
  user.to_json
end

post '/api/user' do # write new review
  age = params['age']
  gender = params['gender']
  occupation = params['occupation']
  zipcode = params['zipcode']

  user = User.new(age: age, gender: gender, occupation: occupation, zipcode: zipcode)
  if user.save
    user.to_json
  else
    error 500
  end
end

put '/api/user/:id/edit' do
  user = User.find(params[:id])
  user.update(params[:id])
  user.to_json
end
