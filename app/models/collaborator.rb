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
	belongs_to :user

end
