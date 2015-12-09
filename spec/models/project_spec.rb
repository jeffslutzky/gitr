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

require 'rails_helper'

RSpec.describe Project, type: :model do
	let(:user1) { FactoryGirl.build(:user) }
	let(:user2) { FactoryGirl.build(:user) }
	let(:user3) { FactoryGirl.build(:user) }
	let(:admin) { FactoryGirl.build(:admin) }
	let(:project) { FactoryGirl.build(:project) }


	describe "#project" do
		# let(:project) { FactoryGirl.build(:project, admin: admin) }
		# let(:user) { FactoryGirl.build(:user, admin: admin) }
		it "has an admin?" do
			expect(project.admin).to_not eq nil
		end
	end

	describe "#project can have collaborators " do
		let(:project) { Project.create({name: "Cool Project"}) }
		let(:user) { User.create({name: "Ian", admin: Admin.new, collaborator: Collaborator.new}) }

		it "is created without collaborators" do
			expect(project.collaborators).to eq []
		end

		it "can have collaborators added to it" do
			project.collaborators << user.collaborator
			expect(project.collaborators).to include(user.collaborator)
			expect(user.collaborator.projects).to include(project)
		end

		it "cannot have the same collaborator added more than once" do
			project.collaborators << user.collaborator
			project.collaborators << user.collaborator
			expect(project.collaborators).to eq [user.collaborator]
		end
	end

	describe "#with_the_most_collaborators" do
		let(:collaborator1) { Collaborator.create }
		let(:collaborator2) { Collaborator.create }
		let(:collaborator3) { Collaborator.create }
		let(:collaborator4) { Collaborator.create }
		let(:project1) { Project.create({name: "Cool Project"	}) }
		let(:project2) { Project.create({name: "Decent Project"}) }

		it "returns the project with the most collaborators" do
			project1.collaborators << collaborator1
			project1.collaborators << collaborator2

			project2.collaborators << collaborator2
			project2.collaborators << collaborator3
			project2.collaborators << collaborator4
			expect(Project.with_the_most_collaborators).to eq project2
		end

	end

	describe "#project can have milestones" do
		let(:project) { Project.create({name: "Cool Project"}) }
		it "is initialized without milestones" do
			expect(project.milestones).to eq []
		end

		it "can have milestones added" do
			project.milestones << Milestone.create(title: "something good")
			project.milestones << Milestone.create(title: "even better")
			expect(project.milestones.count).to eq 2
		end
	end

	describe "#project can have issues" do
		let(:project1) { Project.create }
		let(:project2) { Project.create }
		let(:project3) { Project.create }
		before(:each) {
			3.times {project1.issues.create(title: "Feature")}
			1.times {project2.issues.create(title: "Refactor")}
			4.times {project3.issues.create(title: "Feature2")}
		}

		it "it has issues by association" do
			expect(project1.issues.length).to eq 3
		end

		it "can be sorted by the number of issues" do
			expect(Project.sort_by_number_of_issues).to eq [project3,project1,project2]
		end
	end

end
