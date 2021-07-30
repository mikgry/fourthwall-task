class MovieListSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :movie_times
end
