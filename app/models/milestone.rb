# == Schema Information
#
# Table name: milestones
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  state       :string
#  project_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Milestone < ActiveRecord::Base
  belongs_to :project
  belongs_to :collaborator
  # validation  
  validates :title, presence: true
  validates :title, length: { minimum: 3 }
  validates :description, length: { maximum: 500 }

  def oldest_milestone(project)
  	project.milestones.order(created_at: :asc).first
  end

  def most_recent_milestone(project)
  	project.milestones.order(created_at: :desc).first


end
