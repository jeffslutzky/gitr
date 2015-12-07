# == Schema Information
#
# Table name: issues
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  closed_at  :string
#  updated_at :datetime         not null
#  project_id :integer
#

class Issue < ActiveRecord::Base
  belongs_to :project



end
