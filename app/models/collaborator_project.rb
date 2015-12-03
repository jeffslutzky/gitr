class CollaboratorsProject < ActiveRecord::Base
	belongs_to :project
	belongs_to :collaborator
end
