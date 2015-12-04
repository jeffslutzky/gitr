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

FactoryGirl.define do
  factory :milestone do
    title "MyString"
description "MyString"
state "MyString"
project_id 1
  end

end
