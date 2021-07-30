class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :imdb_rating, :runtime, :released_at

  has_many :movie_times
end
