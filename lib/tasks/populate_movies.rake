desc "Populate Movies table"

task populate_movies: :environment do
  MOVIES_IDS = %w(tt0232500 tt0322259 tt0463985 tt1013752 tt1596343 tt1905041 tt2820852
    tt4630562).freeze

  MOVIES_IDS.each do |id|
    Movie.create!(omdb_id: id)
  end
end
