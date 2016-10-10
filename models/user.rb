require 'active_record'
require_relative '../db/migrate/001_create_users.rb'

# user model
class User < ActiveRecord::Base
  has_many :ratings
  has_many :movies, through: :ratings
end
