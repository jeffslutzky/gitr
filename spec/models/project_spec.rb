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
	let(:user1) { FactoryGirl.build(:user) }
	let(:user2) { FactoryGirl.build(:user) }
	let(:user3) { FactoryGirl.build(:user) }
	# let(:admin) { FactoryGirl.build(:admin) }
	let(:project) { FactoryGirl.build(:project) }

	describe "#project" do
		# let(:project) { FactoryGirl.build(:project, admin: admin) }
		# let(:user) { FactoryGirl.build(:user, admin: admin) }
		it "has an admin?" do
			# binding.pry
			expect(project.admin).to_not eq nil
		end

		# describe "#project can have collaborators" do
		it "has collaborators" do
			binding.pry
			project.collaborators = Collaborator.all
			expect(project.collaborators).to include?(Collaborator.all)
		end
	end
end

