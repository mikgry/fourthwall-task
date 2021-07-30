class MovieTime < ApplicationRecord
  belongs_to :movie

  validates :show_at, presence: true
end
