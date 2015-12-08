# == Schema Information
#
# Table name: collaborators
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Collaborator < ActiveRecord::Base

	has_many :collaborators_projects
	has_many :projects, through: :collaborators_projects
	has_many :milestones
	belongs_to :user

	def projects_ordered_by_date_desc
		Project.joins(:collaborators).where('collaborator_id = ?',self.id).order(created_at: :desc)
	end

end
