class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :github_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
