class AddCollaboratorIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :collaborator_id, :integer
  end
end
