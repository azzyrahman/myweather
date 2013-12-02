class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :type
      t.string :code
      t.string :name
      t.string :state
      t.string :postcode
      t.string :time_zone

      t.timestamps
    end
  end
end
