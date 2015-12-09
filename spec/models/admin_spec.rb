# == Schema Information
#
# Table name: admins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Admin, type: :model do
  before(:each) do
    @admin1 = Admin.create
    @admin2 = Admin.create
    @project1 = Project.create(admin: @admin1)
    @project2 = Project.create(admin: @admin2)
    @project3 = Project.create(admin: @admin2)
    @project4 = Project.create(admin: @admin2)
  end

  describe "admin can have many projects" do
    it "multiple projects can belong to an admin" do
      expect(@admin2.projects).to eq [@project2,@project3,@project4]
    end
  end

  describe "#sort_by_number_of_projects" do
    it "orders admins by the number of projects they are admin for" do
      expect(Admin.sort_by_number_of_projects).to eq [@admin2,@admin1]
    end
  end

end
