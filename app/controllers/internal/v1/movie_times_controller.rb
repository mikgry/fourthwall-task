module Internal
  module V1
    class MovieTimesController < BaseController
      def create
        movie_time = movie.movie_times.create!(create_params)

        render json: movie_time, status: 201
      end

      def destroy
        movie_time = movie.movie_times.find(params[:id])
        movie_time.destroy!
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
