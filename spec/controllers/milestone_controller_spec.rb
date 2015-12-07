require 'rails_helper'

RSpec.describe MilestonesController, type: :controller do

	describe "guest status -" do

			describe "instantiating a new milestone (Milestone.new)" do
				let(:project) { FactoryGirl.create(:project) }
				xit "requires login" do
					get :new
					expect(response).to redirect_to login_url
				end
			end

	end

end