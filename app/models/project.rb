# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string
#  github_repo_id :integer
#  admin_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  url            :string
#

class Project < ActiveRecord::Base

	has_many :collaborators_projects
	has_many :collaborators, through: :collaborators_projects
	has_many :milestones
	belongs_to :admin
	delegate :user, to: :admin

end
