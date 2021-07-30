class AddPriceToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :price, :decimal, null: false, default: BigDecimal("10"),
      precision: 6, scale: 2
  end
end
