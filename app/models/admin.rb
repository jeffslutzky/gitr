# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin < ActiveRecord::Base

	belongs_to :user
	has_many :project_collaborators
	has_many :projects, through: :project_collaborators

end
