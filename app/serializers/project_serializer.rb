class ProjectSerializer < ActiveModel::Serializer
	has_many :milestones

  attributes :id, :milestone_id

end
