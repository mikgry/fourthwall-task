desc "Synchronize movies with omdb API"

task sync_movies: :environment do
  SyncMoviesService.call
end
