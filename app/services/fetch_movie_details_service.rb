require 'dry/monads/do'

class FetchMovieDetailsService < BaseService
  include Dry::Monads[:result]
  include Dry::Monads::Do.for(:call)
  include Dry::Monads[:try]


  API_URL = "http://www.omdbapi.com".freeze

  def initialize(omdb_id)
    self.omdb_id = omdb_id
  end

  def call
    response = yield fetch_details
    if response.status.success?
      Success(JSON::parse(response.to_s))
    else
      Failure(code: :omdb_api_failed, details: {
        http_code: response.code, http_body: response.to_s
      })
    end
  end

  private

  attr_accessor :omdb_id

  def fetch_details
    api_key = Rails.application.credentials.omdb_apikey
    Try(HTTP::Error) do
      HTTP.get(API_URL, params: { apikey: api_key, i: omdb_id })
    end.to_result
  end
end
