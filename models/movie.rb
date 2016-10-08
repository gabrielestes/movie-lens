require 'active_record'
require_relative '../db/migrate/002_create_movies.rb'


class Movie < ActiveRecord::Base
  validates :title, presence: true
  has_many :ratings
  has_many :users, through: :ratings
end