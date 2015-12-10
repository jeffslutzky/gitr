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
#  active         :boolean          default(TRUE)
#

class Project < ActiveRecord::Base

	has_many :collaborators_projects
	has_many :collaborators, -> { uniq }, through: :collaborators_projects
	# the above uses a scope block http://stackoverflow.com/questions/16569994/deprecation-warning-when-using-has-many-through-uniq-in-rails-4
	has_many :milestones
	has_many :issues
	has_many :commits
	belongs_to :admin
	delegate :user, to: :admin

	def self.with_the_most_collaborators
		self.sort_by_number_of_collaborators.first
	end

	def self.sort_by_number_of_collaborators
		self.group('projects.id')
				.select('projects.*,count(collaborators.id) as collaborators_count')
				.joins(:collaborators)
				.order('collaborators_count desc')
	end

	def self.active
    self.where(active: true)
  end

  def self.inactive
    self.where(active: false)
  end

  def add_collaborator(collaborator)
    self.collaborators.push(collaborator)
  end

	def self.sort_by_number_of_issues
		self.select('projects.*, count(issues.id) as issues_count')
			.joins(:issues)
			.group('projects.id')
			.order('issues_count desc')
	end

	def self.name_and_number_of_collaborators
		self.group('projects.name').select('project.name').joins(:collaborators).count('collaborators.id')
	end

	def self.sort_projects_and_number_of_collaborators_desc
		self.name_and_number_of_collaborators.sort{|a,b| b[1] <=> a[1]}
	end

	def get_milestones
		client = Adapters::MilestonesClient.new
		results = client.get_milestones_for_project(self.user.username,self)
	end

	def get_issues
		client = Adapters::IssuesClient.new
		results = client.get_issues_for_project(self.user.username,self)
	end

	def get_commits
		client = Adapters::CommitsClient.new
		results = client.get_commits_for_project(self.user.username,self)
	end

end
