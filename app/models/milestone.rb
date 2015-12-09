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
  # validation
  validates :title, presence: true
  validates :title, length: { minimum: 3 }
  validates :description, length: { maximum: 500 }



end
