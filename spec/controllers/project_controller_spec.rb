require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

	describe "guest status -" do

		describe "instantiating a new project" do
			it "requires login" do
				get :new
				expect(response).to redirect_to login_url
			end
		end

		describe "saving a new project" do
			it "requires login" do
				post :create, id: create(:project), project: attributes_for(:project)
				expect(response).to redirect_to login_url
			end
		end

		describe "editing a project" do
			# let(:project) { FactoryGirl.build(:project) }
			it "requires login" do
				project = create(:project)
				get :edit, id: project
				expect(response).to redirect_to login_url
			end
		end

		describe "saving changes to a project" do
			it "requires login" do
				put :update, id: create(:project), project: attributes_for(:project)
				expect(response).to redirect_to login_url
			end
		end

		describe "destroying a project" do
			it "requires login" do
				delete :destroy, id: create(:project)
				expect(response).to redirect_to login_url
			end
		end

	end

end
