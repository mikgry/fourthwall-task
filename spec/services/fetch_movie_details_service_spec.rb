require "rails_helper"

describe FetchMovieDetailsService, :vcr do
  let(:omdb_id) { "tt0232500" }

  it "returns movie details" do
    response = {
      "Title"=>"The Fast and the Furious", "Year"=>"2001", "Rated"=>"PG-13",
      "Released"=>"22 Jun 2001", "Runtime"=>"106 min",
      "Genre"=>"Action, Crime, Thriller", "Director"=>"Rob Cohen",
      "Writer"=>"Ken Li, Gary Scott Thompson, Erik Bergquist",
      "Actors"=>"Vin Diesel, Paul Walker, Michelle Rodriguez",
      "Plot"=>"Los Angeles police officer Brian O'Conner must decide where his " +
      "loyalty really lies when he becomes enamored with the street racing world " +
      "he has been sent undercover to destroy.",
      "Language"=>"English, Spanish", "Country"=>"United States, Germany",
      "Awards"=>"11 wins & 18 nominations",
      "Poster"=>"https://m.media-amazon.com/images/M/MV5BNzlkNzVjMDMtOTdhZC00MGE1LTkxODctMzFmMjkwZmMxZjFhXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg",
      "Ratings"=>[
        {"Source"=>"Internet Movie Database", "Value"=>"6.8/10"},
        {"Source"=>"Rotten Tomatoes", "Value"=>"54%"},
        {"Source"=>"Metacritic", "Value"=>"58/100"}
      ],
      "Metascore"=>"58", "imdbRating"=>"6.8", "imdbVotes"=>"361,940",
      "imdbID"=>"tt0232500", "Type"=>"movie", "DVD"=>"10 Sep 2015",
      "BoxOffice"=>"$144,533,925",
      "Production"=>"Original Film, Neal H. Moritz Productions, Universal Pictures",
      "Website"=>"N/A", "Response"=>"True"
    }

    expect(described_class.call(omdb_id)).to eq(Dry::Monads::Result::Success.new(response))
  end

  context "error status code" do
    it "returns failure code & details" do
      allow(Rails.application.credentials).to receive(:omdb_apikey).and_return("dummy")

      body = "{\"Response\":\"False\",\"Error\":\"Invalid API key!\"}"
      result = { code: :omdb_api_failed, details: { http_code:401, http_body: body } }

      expect(described_class.call(omdb_id)).to eq(
        Dry::Monads::Result::Failure.new(result)
      )
    end
  end

  context "HTTP Error" do
    it "returns failure code & details" do
      error = HTTP::Error.new("error")
      allow(HTTP).to receive(:get).and_raise(error)

      expect(described_class.call(omdb_id)).to eq(
        Dry::Monads::Result::Failure.new(error)
      )
    end
  end
end
