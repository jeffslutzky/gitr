class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :message
      t.string :url
      t.datetime :date
      t.integer :project_id
      t.integer :collaborator_id
    end
  end
end
