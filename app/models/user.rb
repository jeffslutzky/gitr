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
				# name is not provided in collaborator_hash
				# setting name to login instead to pass user validations
				name: collaborator_hash[:login],
				# login is provided in collaborator_hash, but is not in our users table
				uid: collaborator_hash[:id]
			})
			@user.build_admin
			@user.build_collaborator
			@user.admin.save
			@user.collaborator.save
		end
		project.collaborators << @user.collaborator
	end

	def collaborators
		users_projects = self.collaborator.projects
		users_projects.each_with_object([]) do |project, arr|
			project.collaborators.each{|collaborator| arr << collaborator.user}
		end.flatten.uniq

		# Collaborator.group('collaborators.id').select('collaborators.*,where(collaborators_projects.collaborator_id=1) as users_projects').joins(:projects).where(collaborator.id: user.collaborator.id)
		# 						.where(collaborators.id)
	end

end
