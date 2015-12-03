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
#

require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { FactoryGirl.build(:user) }
	let(:admin) { FactoryGirl.build(:admin) }


	describe "#has correct admin?" do
		let(:user) { FactoryGirl.build(:user, admin: admin) }
		it "has correct admin if admin's user_id matches user's id" do
			expect(user.admin.user_id).to eq user.id 
		end

	end
end
