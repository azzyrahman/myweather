class RenameTypeAndClodeColumnsOfLocation < ActiveRecord::Migration
  def change
    change_table :locations do |t|
      t.rename :type, :loc_type
      t.rename :code, :loc_code
    end

  end
end
