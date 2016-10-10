require 'active_record'
require_relative '../db/migrate/002_create_movies.rb'

# movie model
class Movie < ActiveRecord::Base
  validates :title, presence: true
  has_many :ratings
  has_many :users, through: :ratings

  def get_average_rating
    self.ratings.average(:score).to_f.round(1)
  end
end
