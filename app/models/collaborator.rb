# == Schema Information
#
# Table name: collaborators
#
#  id         :integer          not null, primary key
#  github_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Collaborator < ActiveRecord::Base

	has_many :project_collaborators
	has_many :projects, through: :project_collaborators

end
