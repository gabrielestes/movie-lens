require 'active_record'

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
end

class Movie < ActiveRecord::Base
  validates :title, presence: true
  has_many :ratings
  has_many :users, through: :ratings
end

class User < ActiveRecord::Base
  has_many :ratings
  has_many :movies, through: :ratings
end
