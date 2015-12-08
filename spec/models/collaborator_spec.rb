# == Schema Information
#
# Table name: collaborators
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Collaborator, type: :model do
	# let(:collaborator) {FactoryGirl.build(:collaborator, user: user)}

	describe "#collaborator has projects" do
		let(:collaborator) { Collaborator.create }
		let(:project) { Project.create }

		it "can be added to a project" do
			project.collaborators << collaborator
			binding.pry
			expect(collaborator.projects).to include project
		end
	end

	describe "#collaborator's projects ordered by date"
		let(:collaborator) { Collaborator.create}
		let(:project1) { Project.create(created_at: Date.new(2015,6,3) ) }
		let(:project2) { Project.create(created_at: Date.new(2014,12,11) ) }
		let(:project3) { Project.create(created_at: Date.new(2015,6,4) ) }
		it "has projects ordered by date created" do
			collaborator.projects = [project1,project2,project3]
			expect(collaborator.projects_ordered_by_date_desc).to eq [project3,project1,project2]
		end

	end

end
