class CreateMovieTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_times do |t|
      t.references :movie, foreign_key: true
      t.time :show_at, null: false
      t.timestamps
    end
  end
end
