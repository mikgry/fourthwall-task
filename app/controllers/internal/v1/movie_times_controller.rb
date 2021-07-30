module Internal
  module V1
    class MovieTimesController < BaseController
      def create
        movie_time = movie.movie_times.create!(create_params)

        render json: movie_time.as_json(only: [:id, :show_at]), status: 201
      end

      private

      def create_params
        {
          show_at: Time.zone.parse(
            params.require(:movie_time).permit(:show_at)[:show_at]
          )
        }
      end

      def movie
        Movie.find(params[:movie_id])
      end
    end
  end
end
