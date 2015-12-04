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

end
