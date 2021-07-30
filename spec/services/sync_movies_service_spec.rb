require "rails_helper"

describe SyncMoviesService do
  let!(:movie) { create :movie }
  let!(:synced_movie) { create :movie, :synced }
  let(:movie_details) { {
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
  } }
  let(:attributes) { {
    title: movie_details["Title"],
    description: movie_details["Plot"],
    runtime: movie_details["Runtime"],
    released_at: movie_details["Released"],
    imdb_rating: movie_details["imdbRating"],
  } }

  subject { described_class.call }

  it "updates unsynced movies" do
    expect(FetchMovieDetailsService).to receive(:call).with(movie.omdb_id).and_return(
      Dry::Monads::Result::Success.new(movie_details)
    )
    expect(FetchMovieDetailsService).to_not receive(:call).with(synced_movie.omdb_id)
    expect(UpdateMovieService).to receive(:call).with(movie.id, attributes)
    subject
  end
end
