# == Schema Information
#
# Table name: issues
#
#  id              :integer          not null, primary key
#  title           :string
#  body            :text
#  state           :string
#  created_at      :datetime         not null
#  closed_at       :string
#  updated_at      :datetime         not null
#  project_id      :integer
#  collaborator_id :integer
#

class Issue < ActiveRecord::Base
  belongs_to :project
  belongs_to :collaborator
  #validation
  validates :title, presence: true
  validates :title, length: { minimum: 3 }
  validates :body, length: { maximum: 500 }


  def milestones
    return 'no project' unless project
    project.milestones
  end

  def self.sorted_by_date_desc
    self.order('date desc')
  end

end
