class MovieSerializer < ActiveModel::Serializer
  attributes :id, :price, :title, :description, :imdb_rating, :runtime, :released_at

  has_many :movie_times
end
