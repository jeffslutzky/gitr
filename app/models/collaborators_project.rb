# == Schema Information
#
# Table name: collaborators_projects
#
#  collaborator_id :integer
#  project_id      :integer
#

class CollaboratorsProject < ActiveRecord::Base
	belongs_to :project
	belongs_to :collaborator
end
