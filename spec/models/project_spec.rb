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
#

require 'rails_helper'

RSpec.describe Project, type: :model do
	let(:user) { FactoryGirl.build(:user) }
	let(:admin) { FactoryGirl.build(:admin) }
	let(:project) { FactoryGirl.build(:project) }

	describe "#project has correct admin?" do
		let(:project) { FactoryGirl.build(:project, admin: admin) }
		let(:user) { FactoryGirl.build(:user, admin: admin) }
		it "has an admin attribute corresponding to the correct admin" do
			expect(project.admin).to eq user.admin
		end
	end	
end

