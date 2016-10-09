require 'sinatra'
require 'active_record'
# require_relative 'environment'
# require_relative 'classes'
require_relative 'models/user'
require_relative 'models/movie'
require_relative 'models/rating'
require 'json'
require 'sinatra/cross_origin'

database_config = YAML::load(File.open('config/database.yml'))

before do
 ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
 content_type :json
end

after do
 ActiveRecord::Base.connection.close
end

register Sinatra::CrossOrigin

configure do
  enable :cross_origin
end

get '/api/movies' do
  title = params['title']
  release_date = params['release_date']
  url = params['url']

  if !title.nil?
    movies = Movie.where(title: title, release_date: release_date)
  else
    movies = Movie.all.order(title: :DESC)
  end

  movies.to_json
end

get '/api/movie' do

  movie = Movie.select(:id, :title).where("title LIKE ?", "%#{params['search']}%").first
  p movie.get_average_rating
  movie.to_json
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

get '/api/rate' do
  erb :rate
end
