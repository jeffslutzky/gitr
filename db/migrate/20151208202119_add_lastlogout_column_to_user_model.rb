class AddLastlogoutColumnToUserModel < ActiveRecord::Migration
  def change
    add_column :users, :lastlogout, :datetime
  end
end
