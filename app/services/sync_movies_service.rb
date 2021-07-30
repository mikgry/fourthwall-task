require 'dry/monads/do'

class SyncMoviesService < BaseService
  include Dry::Monads::Do.for(:call)

  def call
    unsynced_movies.find_each do |movie|
      movie_details = yield FetchMovieDetailsService.call(movie.omdb_id)
      UpdateMovieService.call(movie.id, movie_params(movie_details))
    end
  end

  private

  attr_accessor :movie_id, :attributes

  def unsynced_movies
    Movie.where(omdb_synced: false)
  end

  def movie_params(movie_details)
    {
      title: movie_details["Title"],
      released_at: movie_details["Released"],
      runtime: movie_details["Runtime"],
      imdb_rating: movie_details["imdbRating"],
      description: movie_details["Plot"]
    }
  end
end
