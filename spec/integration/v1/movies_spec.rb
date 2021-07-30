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
end
