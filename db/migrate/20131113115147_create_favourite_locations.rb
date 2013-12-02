class CreateFavouriteLocations < ActiveRecord::Migration
  def change
    create_table :favourite_locations do |t|

      t.references :user
      t.references :location

      t.timestamps
    end
  end
end
