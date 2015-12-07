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
#  description    :text
#

class Project < ActiveRecord::Base

	has_many :collaborators_projects
	has_many :collaborators, -> { uniq }, through: :collaborators_projects
	# the above uses a scope block http://stackoverflow.com/questions/16569994/deprecation-warning-when-using-has-many-through-uniq-in-rails-4
	has_many :milestones
	has_many :issues
	belongs_to :admin
	delegate :user, to: :admin

	def self.with_the_most_collaborators
		# Project.select('projects.*,count(collaborators.id) as collaborators_count').joins(:collaborators).group('projects.id').order('collaborators_count desc limit 1')
		Project.group('projects.id')
					 .select('projects.*,count(collaborators.id) as collaborators_count')
					 .joins(:collaborators).order('collaborators_count desc limit 1')[0]
	end

end
