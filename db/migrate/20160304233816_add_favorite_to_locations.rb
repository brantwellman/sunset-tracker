class AddFavoriteToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :favorite, :integer, default: 0
  end
end
