# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin < ActiveRecord::Base

	belongs_to :user
	has_many :projects

	def self.sort_by_number_of_projects
		Admin.select('admins.*, count(projects.id) as project_count').joins(:projects).group("admins.id").order('project_count desc')
	end
end
