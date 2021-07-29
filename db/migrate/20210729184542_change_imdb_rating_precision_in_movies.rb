class ChangeImdbRatingPrecisionInMovies < ActiveRecord::Migration[6.1]
  def up
    change_column :movies, :imdb_rating, :decimal, precision: 3, scale: 1
  end
end
