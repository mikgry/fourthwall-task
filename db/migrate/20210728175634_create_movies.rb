class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :omdb_id, null: false, unique: true
      t.boolean :omdb_synced, null: false, default: false
      t.string :title
      t.text :description
      t.decimal :imdb_rating, precision: 1
      t.date :released_at
      t.string :runtime

      t.timestamps
    end
  end
end
