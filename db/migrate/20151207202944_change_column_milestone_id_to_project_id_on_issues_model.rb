class ChangeColumnMilestoneIdToProjectIdOnIssuesModel < ActiveRecord::Migration
  def change
    add_column :issues, :project_id, :integer
    remove_column :issues, :milestone_id
  end
end
