class UpdateMovieService < BaseService
  include Dry::Monads[:result]

  def initialize(movie_id, attributes)
    self.movie_id = movie_id
    self.attributes = attributes
  end

  def call
    movie = Movie.find(movie_id)
    if(movie.update(movie_params))
      Success(movie)
    else
      Failure(code: :movie_update_failed, details: movie.errors)
    end
  end

  private

  attr_accessor :movie_id, :attributes

  def movie_params
    attributes.slice(:title, :description, :runtime, :imdb_rating, :released_at).compact.merge(
      omdb_synced: true
    )
  end
end
