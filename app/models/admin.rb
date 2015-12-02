# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  github_id  :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Admin < ActiveRecord::Base

	has_many :projects

	
end
