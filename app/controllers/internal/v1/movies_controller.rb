module Internal
  module V1
    class MoviesController < BaseController
      def update
        movie.update!(update_params)
        render json: movie.as_json(only: [:id, :price])
      end

      private

      def update_params
        {
          price: BigDecimal(params.require(:movie).permit(:price)[:price])
        }
      end

      def movie
        Movie.find(params[:id])
      end
    end
  end
end
