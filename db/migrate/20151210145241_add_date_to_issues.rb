class AddDateToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :date, :datetime
  end
end
