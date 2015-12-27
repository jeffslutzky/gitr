require 'rails_helper'

describe Project, type: :model do

	describe '#admin' do
		let(:admin) { Admin.new }
		let(:project) { admin.projects.build }

		it "returns the admin of a project" do
			expect(project.admin).to eq admin
		end
	end

	describe "#collaborators " do
		let(:user)   { User.create() }
		let(:project) { Project.create }

		it "returns collaborators associated with a project" do
			expect(project.collaborators).to eq []
		end

		it "can have collaborators added to it" do
			project.collaborators << user.collaborator
			expect(project.collaborators).to include(user.collaborator)
			expect(user.collaborator.projects).to include(project)
		end

		it "cannot have the same collaborator added more than once" do
			2.times { project.collaborators << user.collaborator }
			expect(project.collaborators).to eq [user.collaborator]
		end
	end

	describe "#with_the_most_collaborators" do
		let(:collaborator1) { Collaborator.new }
		let(:collaborator2) { Collaborator.new }
		let(:collaborator3) { Collaborator.new }
		let(:collaborator4) { Collaborator.new }
		let(:project1)      { Project.create() }
		let(:project2)      { Project.create() }

		it "returns the project with the most collaborators" do
			project1.collaborators << collaborator1
			project1.collaborators << collaborator2

			project2.collaborators << collaborator2
			project2.collaborators << collaborator3
			project2.collaborators << collaborator4

			expect(Project.with_the_most_collaborators).to eq project2
		end

	end

	describe "#milestones" do
		let(:project) { Project.create() }
		it "returns milestones associated with the project" do
			expect(project.milestones).to_not eq nil
		end

		it "can have milestones added to it" do
			project.milestones << Milestone.new(title: "something good")
			project.milestones << Milestone.new(title: "even better")
			expect(project.milestones.count).to eq 2
		end
	end

	describe "#issues" do
		let(:project) { Project.create }

		it "returns issues associated with the project" do
			expect(project.issues).to eq []

			3.times {project.issues.create}
			expect(project.issues.length).to eq 3
		end
	end

	describe "#issues_sorted_desc" do
		let(:project) { Project.create }
		let(:issues)  { Array.new(5).each_with_object([]){ project.issues.create}	}

		it "returns issues associated with the project, sorted by newest to oldest" do
			expect(project.issues_sorted_desc).to eq issues.reverse
		end
	end

	describe '.sort_by_number_of_issues' do
		let(:project1) { Project.create }
		let(:project2) { Project.create }
		let(:project3) { Project.create }
		before(:each) {
			3.times { project1.issues.create(title: "Feature")}
			1.times { project2.issues.create(title: "Refactor")}
			4.times { project3.issues.create(title: "Feature2")}
		}

		it "returns all projects, sorted by the number of issues" do
			expect(Project.sort_by_number_of_issues).to eq [project3,project1,project2]
		end
	end

	describe '.sort_by_number_of_collaborators' do
		let(:project1) { Project.create }
		let(:project2) { Project.create }
		let(:project3) { Project.create }
		before(:each) {
			1.times { project1.collaborators.create }
			3.times { project2.collaborators.create }
			5.times { project3.collaborators.create }
		}

		it "returns all projects, sorted by the number of collaborators" do
			expect(Project.sort_by_number_of_collaborators).to eq [project3,project2,project1]
		end
	end

	describe '.active' do
		let(:project1) { Project.create(active: true) }
		let(:project2) { Project.create(active: false) }

		it "returns active projects" do
			expect(Project.active).to include(project1)
		end

		it "does not return non-active projects" do
			expect(Project.active).to_not include(project2)
		end
	end

end
