require 'swagger_helper'

describe 'Movies API' do
  path '/v1/movies' do
    get 'Get all movies' do
      tags 'Movies'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer, nullable: true


      response '200', 'list_movies' do
        schema type: :array,
          items: {
            id: { type: :integer },
            title: { type: :string },
            movie_times: { type: :array, items: {
              id: { type: :integer },
              show_at: { type: :string }
            } }
          }
        let(:movie_object) { create :movie }
        let(:page) { 1 }
        run_test!
      end
    end
  end

  path '/v1/movies/{id}' do
    get 'Get all movies' do
      tags 'Movies'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response '200', 'movie details' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            description: { type: :string },
            imdb_rating: { type: :string },
            runtime: { type: :string },
            released_at: { type: :string },
            price: { type: :string },
            movie_times: { type: :array, items: {
              id: { type: :integer },
              show_at: { type: :string }
            } }
          }
        let(:movie) { create :movie, :synced }
        let(:id) { movie.id }
        run_test!
      end

      response '404', 'movie not found' do
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        let(:id) { 1 }
        run_test!
      end
    end
  end
end
