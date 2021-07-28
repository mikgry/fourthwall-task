class Movie < ApplicationRecord
  validates :omdb_id, uniqueness: true, presence: true
end
