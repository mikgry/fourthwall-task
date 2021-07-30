class Movie < ApplicationRecord
  has_many :movie_times, dependent: :destroy

  validates :omdb_id, uniqueness: true, presence: true
end
