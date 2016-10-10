require 'active_record'
require_relative '../db/migrate/003_create_ratings.rb'

# rating model
class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
end
