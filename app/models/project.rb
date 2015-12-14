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
	# Can we specify to allow nil nto be set to true
	delegate :user, to: :admin, allow_nil: true

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

  def self.find_push_events(all_repo_events)
		push_events = []
		all_repo_events.each do |event|
			if event.type == "PushEvent"
				push_events << event
			end
		end
		return push_events
	end

	def commits_sorted_desc
		self.commits.sorted_by_date_desc
	end

	def five_most_recent_commits
		commits_sorted_desc.first(5)
	end

	def issues_sorted_desc
		self.issues.sorted_by_date_desc
	end

	def five_most_recent_issues
		issues_sorted_desc.first(5)
	end

	def milestones_sorted_desc
		self.milestones.sorted_by_date_desc
	end

	def five_most_recent_milestones
		milestones_sorted_desc.first(5)
	end

	def self.sort_by_number_of_commits
		self.select('projects.*, count(commits.id) as count_commits').group('projects.id').joins(:commits).order('count_commits desc')
	end

	def self.number_of_commits_by_user_on_active_projects(user)
		self.active.map do |project|
			project.commits.where('collaborator_id = ?', user.collaborator.id).count
		end
		# Project.group('projects.name').joins(:commits).joins(:collaborators).count('commits.collaborator_id = 1')
		end

end
