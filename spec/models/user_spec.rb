# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  uid        :integer
#  provider   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string
#  avatar_url :string
#  lastlogout :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { FactoryGirl.build(:user) }

	describe "#has correct admin?" do
		it "has correct admin if admin's user_id matches user's id" do
			expect(user.admin.user_id).to eq user.id
		end
	end

	describe "#Users are collaborators (Testing correct association)" do
		it "has correct collaborator" do
			expect(user.collaborator.user_id).to eq user.id
		end
	end

	describe "#user has necessary attributes?" do
		let(:user) { FactoryGirl.build(:user) }
		it 'has a name' do
			expect(user.name).to_not eq nil
		end
		it 'has a uid' do
			#Relying on Github oAuth
			expect(user.uid).to_not eq nil
		end
	end

	#Need to discuss testing funitonality of Email i.e. public vs. Private etc

	describe "#user has collaborators" do
		let(:user1) { User.create(name: "Jeff", admin: Admin.new, collaborator: Collaborator.new) }
		let(:user2) { User.create(name: "Deniz", admin: Admin.new, collaborator: Collaborator.new) }
		let(:user3) { User.create(name: "Ian", admin: Admin.new, collaborator: Collaborator.new) }
		let(:user4) { User.create(name: "Vinny", admin: Admin.new, collaborator: Collaborator.new) }
		let(:project) { Project.create(name: "Trello") }
		before(:each) { project.collaborators << [user1.collaborator,user2.collaborator] }

		it "has projects as a collaborator" do
			expect(user1.projects).to eq [project]
			expect(user2.projects).to eq [project]
			expect(user3.projects).to_not eq [project]
		end

		it "has collaborators through projects" do
			expect(user1.collaborators).to include user2
			expect(user1.collaborators).to_not include user3
			project.collaborators << user3.collaborator
			expect(user2.collaborators).to include user3
		end

	end
end
