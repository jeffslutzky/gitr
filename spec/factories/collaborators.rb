# == Schema Information
#
# Table name: collaborators
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :collaborators do
  	FactoryGirl.build(:collaborator)
  	FactoryGirl.build(:collaborator)
  end

end
