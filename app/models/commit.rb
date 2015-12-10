# == Schema Information
#
# Table name: commits
#
#  id              :integer          not null, primary key
#  message         :string
#  url             :string
#  date            :datetime
#  project_id      :integer
#  collaborator_id :integer
#

class Commit < ActiveRecord::Base
  belongs_to :collaborator
  belongs_to :project

end
