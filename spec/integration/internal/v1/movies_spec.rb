require 'swagger_helper'

describe 'Movies API' do
  path '/internal/v1/movies/{id}' do
    patch 'Set price of the movie' do
      tags 'Movies'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :movie, in: :body, schema: {
        type: :object,
        properties: {
          price: { type: :number }
        },
        required: [ 'price' ]
      }


      response '200', 'price updated' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            price: { type: :string }
          }
        let(:movie_object) { create :movie }
        let(:movie) { { price: BigDecimal("10.1") } }
        let(:id) { movie_object.id }
        run_test! do |response|
          expect(movie_object.reload.price).to eq(movie[:price])
        end
      end

      response '422', 'wrong price value' do
        schema type: :object,
          properties: {
            error: { type: :object }
          }
        let(:movie_object) { create :movie }
        let(:movie) { { price: BigDecimal("-10.1") } }
        let(:id) { movie_object.id }
        run_test!
      end

      response '404', 'movie not found' do
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        let(:id) { 1 }
        let(:movie) { { price: BigDecimal("10.1") } }
        run_test!
      end
    end
  end
end
