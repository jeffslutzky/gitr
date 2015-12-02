require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { FactoryGirl.build(:user) }
	let(:admin) { FactoryGirl.build(:admin) }


	describe "#has_correct_admin?" do
		let(:user) { FactoryGirl.build(:user, admin: admin) }
		it "has correct admin if admin's user_id matches user's id" do
			expect(user.admin.user_id).to eq user.id 
		end

	end
end
