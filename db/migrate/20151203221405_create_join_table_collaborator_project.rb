class CreateJoinTableCollaboratorProject < ActiveRecord::Migration
  def change
    create_join_table :collaborators, :projects do |t|
      t.integer :collaborator_id
      t.integer :project_id
    end
  end
end	