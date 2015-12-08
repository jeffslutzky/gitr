class AddDefaultValueToProjectAttribute < ActiveRecord::Migration

	def change
	   change_column :projects, :active, :boolean, :default => true
	end

end
