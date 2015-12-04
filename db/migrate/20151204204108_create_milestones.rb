class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :title
      t.string :description
      t.string :state
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
