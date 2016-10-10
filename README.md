# Movie Lens Online


##Synopsis

####This API may be used for the purpose of searching for movie by title, searching for users, updating user info, adding movies to the database, and posting movie ratings. Each movie has a calculated average based on accumulated ratings for the title.

===

##Format

####This API is structured using the Sinatra Ruby framework, an open-source library that is frequently used to deploy web applications.

####Movie Lens Online API provides JSON objects for each feature listed above. This allows for front-end developers to configure a web page using information gathered from thousands of reviews, hundreds of movies, and hundreds of users.

####The files are organized to be deployable to Heroku, with migration files within 'db/migrate/', the movie, user, and rating models within '/models', and a 'public' folder for HTML, JS, and CSS files.

===

##Code

####The following snippet is a behavior that can be used to search for a movie and retrieve its average rating.

```Ruby
get '/api/movie' do
  movie = Movie.select(:id, :title).where("title LIKE ?", "%#{params['search']}%").first
  movie.get_average_rating
  movie.to_json
end
```

####This next snippet allows for users to create a rating.

```Ruby
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
```

===

##Data

####The database used for this API was downloaded via GroupLens, a research organization which has provided web sites such as movielens.org with large movie rating datasets. For this particular API the 100k dataset was used, however, Heroku (free) provides a maximum of 10,000 rows of data. Therefore, the data pool for this API was reduced to 5,000 ratings.

http://grouplens.org/datasets/movielens/

===

##Languages
####Written in Ruby


##Author
####Gabriel Estes
