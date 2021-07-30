module V1
  class MoviesController < BaseController
    def index
      movies = Movie.where(omdb_synced: true).includes(:movie_times).page(params[:page])
      render json: movies, each_serializer: MovieListSerializer
    end
  end
end
