class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.text :body
      t.integer :milestone_id
      t.string :created_at
      t.string :closed_at

      t.timestamps null: false
    end
  end
end
