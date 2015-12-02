# == Schema Information
#
# Table name: projects
#
#  id         :integer          not null, primary key
#  name       :string
#  github_id  :integer
#  admin_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Project < ActiveRecord::Base

	has_many :project_collaborators
	has_many :collaborators, through: :project_collaborators
	belongs_to :admin

end
