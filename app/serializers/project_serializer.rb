class ProjectSerializer < ActiveModel::Serializer
	has_many :milestones

  attributes :id, :milestone_id

  #   def attributes
  #   attributes = super
  #   attributes[:milestone] = object.milestone.try(:as_json)
  #   attributes
  # end
  
end
