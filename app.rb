require 'sinatra'
require 'active_record'
require_relative 'environment'
require_relative 'classes'
require 'json'

before do
  content_type :json
end

get '/api/movies' do
  title = params['title']
  release_date = params['release_date']
  url = params['url']

  if !title.nil?
    movies = Movies.where(title: title, release_date: release_date)
  else
    movies = Movie.all.order(title: :DESC)
  end

  movies.to_json
end

get '/api/movie' do
  # title = params['title']

  movie = Movie.select(:id, :title).where("title LIKE ?", "%#{params['search']}%")

  movie.to_json
end

post '/api/movies' do # write new review
  title = params['title']
  release_date = params['release_date']
  score = params['score']

  rating = Rating.create(title: title, release_date: release_date)
end
