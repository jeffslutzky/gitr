# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  uid        :integer
#  provider   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string
#  avatar_url :string
#  lastlogout :datetime
#

class User < ActiveRecord::Base

	has_one :admin
	has_one :collaborator
	has_many :projects, through: :admin
	has_many :projects, through: :collaborator

	validates :name, presence: true
  #validates :email, uniqueness: true
   #allow_nil: true

	def self.create_from_omniauth(auth_hash)
	  user = self.create(
	  	provider: auth_hash[:provider],
      uid: auth_hash[:uid],
      name: auth_hash[:info][:name],
      username: auth_hash[:login],
      avatar_url: auth_hash[:extra][:raw_info][:avatar_url]
			)
    admin = user.build_admin
    admin.save
    collaborator = user.build_collaborator
    collaborator.save
		user
	end

	def self.find_or_create_from_api(project,collaborator_hash)

		@user = User.find_by(uid: collaborator_hash[:id])
		if !@user
			@user = User.create({
				name: collaborator_hash[:login],
				username: collaborator_hash[:login],
				uid: collaborator_hash[:id],
				admin: Admin.create,
				collaborator: Collaborator.create
			})
			# @user.build_admin
			# @user.admin.save
			# @user.build_collaborator.save
			# @user.save
			# collaborator.projects << project
			# collaborator.save
			# @user.collaborator.save
		end

		# some logic to treat strange failure mode
		if !@user.collaborator
			@user.build_admin.save
			@user.build_collaborator.save
		end
		# begin
			project.collaborators << @user.collaborator
		# rescue

			# binding.pry
		# end
	end

	def collaborators
		users_projects = self.collaborator.projects
		users_projects.each_with_object([]) do |project, arr|
			project.collaborators.each{|collaborator| arr << collaborator.user}
		end.flatten.uniq

	end

  def numberOfProject
    numbProject = self.admin.projects.count
  end

	def projects_and_number_of_collaborators
		self.projects.group('projects.name').select('project.name').joins(:collaborators).count('collaborators.id')
	end

	def sort_projects_and_number_of_collaborators_desc
		self.projects_and_number_of_collaborators.sort{|a,b| b[1] <=> a[1]}
	end

	def self.issues_since_logout(current_user)
		#Shows all issues since a user logged out
		lastlogout = current_user.lastlogout
		Issue.where('created_at > ?', lastlogout )
	end

	def self.milestones_since_logout(current_user)
		lastlogout = current_user.lastlogout
		Milestone.where('created_at > ?', lastlogout )
	end

  def self.not_a_collaborator(project)
  	collaborators_array = Collaborator.all - project.collaborators
  	user_array = collaborators_array.map do |collaborator|
  		collaborator.user
  	end
		user_array
  end

	def active_projects
		self.projects.sort_projects_and_number_of_collaborators_desc.active
	end

	def total_number_of_commits
		Commit.joins(:project).joins(:collaborator).where("collaborators.id = ?", self.id).count
	end

end
