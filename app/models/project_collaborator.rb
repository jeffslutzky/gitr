class ProjectCollaborator < ActiveRecord::Base
	belongs_to :project
	belongs_to :collaborator
end
