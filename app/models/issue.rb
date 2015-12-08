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
  #validation 
  validates :title, presence: true
  validates :title, length: { minimum: 3 }
  validates :body, length: { maximum: 500 } 
  

  def milestones
    return 'no project' unless project
    project.milestones
  end

  

end
