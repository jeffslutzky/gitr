class AddDateToMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :date, :datetime
  end
end
