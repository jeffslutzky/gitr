# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string
#  github_repo_id :integer
#  admin_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  url            :string
#  description    :text
#  active         :boolean          default(TRUE)
#

FactoryGirl.define do
  factory :project do
    name "My Project"
    github_repo_id "99999"
    association :admin

  end

end
