class AddActiveToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :active, :boolean
  end
end
