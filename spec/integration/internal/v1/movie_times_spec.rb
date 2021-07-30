require 'swagger_helper'

describe 'MovieTimes API' do
  path '/internal/v1/movies/{movie_id}/movie_times' do
    post 'Create movie time' do
      tags 'Movies', 'MovieTimes'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :movie_id, in: :path, type: :string
      parameter name: :movie_time, in: :body, schema: {
        type: :object,
        properties: {
          show_at: { type: :string }
        },
        required: [ 'movie_time' ]
      }


      response '201', 'movie_time created' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            show_at: { type: :string }
          }
        let(:movie_time) { { movie_time: { show_at: "12:00" } } }
        let(:movie_object) { create :movie }
        let(:movie_id) { movie_object.id }

        run_test! do
          expect(movie_object.movie_times.count).to eq(1)
          expect(
            movie_object.movie_times.last.show_at.strftime("%H:%M")
          ).to eq("12:00")
        end
      end

      response '422', 'wrong time value' do
        schema type: :object,
          properties: {
            error: { type: :object }
          }
        let(:movie_time) { { movie_time: { show_at: "p" } } }
        let(:movie_object) { create :movie }
        let(:movie_id) { movie_object.id }
        run_test!
      end

      response '404', 'movie not found' do
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        let(:movie_id) { 1 }
        let(:movie_time) { { movie_time: { show_at: "12:00" } } }
        run_test!
      end
    end
  end

  path '/internal/v1/movies/{movie_id}/movie_times/{id}' do
    delete 'Create movie time' do
      tags 'Movies', 'MovieTimes'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :movie_id, in: :path, type: :string
      parameter name: :id, in: :path, type: :string


      response '204', 'movie_time destroyed' do
        let(:movie_time) { create :movie_time, movie: movie }
        let(:movie) { create :movie }
        let(:movie_id) { movie.id }
        let(:id) { movie_time.id }

        run_test! do
          expect(movie.movie_times.count).to eq(0)
        end
      end

      response '404', 'movie time not found' do
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        let(:movie) { create :movie }
        let(:movie_id) { movie.id }
        let(:id) { 1 }
        run_test!
      end
    end
  end
end
