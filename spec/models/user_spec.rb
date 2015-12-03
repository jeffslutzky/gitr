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

	describe "#has correct admin?" do
		it "has correct admin if admin's user_id matches user's id" do
			expect(user.admin.user_id).to eq user.id
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

	end
end
