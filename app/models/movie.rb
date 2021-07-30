class Movie < ApplicationRecord
  has_many :movie_times, dependent: :destroy

  validates :omdb_id, uniqueness: true, presence: true
  validates :price, numericality: { greater_than: 0 }
end
