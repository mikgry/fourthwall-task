module V1
  class MoviesController < BaseController
    def index
      movies = Movie.where(omdb_synced: true).includes(:movie_times).page(params[:page])
      render json: movies, each_serializer: MovieListSerializer
    end

    def show
      movie = Movie.where(omdb_synced: true).find(params[:id])
      render json: movie
    end
  end
end
