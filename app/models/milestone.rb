# == Schema Information
#
# Table name: milestones
#
#  id              :integer          not null, primary key
#  title           :string
#  description     :string
#  state           :string
#  project_id      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  collaborator_id :integer
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

  def newest_milestone_created_by_collaborator(collaborator)
  	collaborator.milestones.order(created_at: :desc).first
  end

  def self.newest_milestone_on_site
  	self.all.order(created_at: :desc).first
  end


end
