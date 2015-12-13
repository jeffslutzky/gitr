class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.string :message
    	t.integer :user_id
    	t.boolean :unread, default: true
      t.timestamps null: false
    end
  end
end
