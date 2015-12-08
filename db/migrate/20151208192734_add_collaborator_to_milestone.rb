class AddCollaboratorToMilestone < ActiveRecord::Migration
  def change
    add_column :milestones, :collaborator_id, :integer
  end
end
