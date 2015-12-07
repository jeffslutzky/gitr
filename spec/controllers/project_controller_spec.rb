require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

	describe "guest status -" do

		describe "instantiating a new project (Project.new)" do
			it "requires login" do
				get :new
				expect(response).to redirect_to login_url
			end
		end

		describe "saving a new project (Project.create)" do
			let(:project) { FactoryGirl.build(:project) }
			xit "requires login" do
				post :save, id: save(:project), project: attributes_for(:project)
				expect(response).to redirect_to login_url
			end
		end

		describe "editing a project (Project.edit)" do
			let(:project) { FactoryGirl.create(:project) }
			it "requires login" do
				get :edit, id: project
				expect(response).to redirect_to login_url
			end
		end

		describe "showing a project (Project.show)" do
			let(:project) { FactoryGirl.create(:project) }
			it "requires login" do
				get :show, id: project
				expect(response).to redirect_to login_url
			end
		end

		describe "saving changes to a project (Project.update)" do
			let(:project) { FactoryGirl.create(:project) }
			xit "requires login" do
				put :update, id: create(:project), project: attributes_for(:project)
				expect(response).to redirect_to login_url
			end
		end

		describe "destroying a project (Project.destroy)" do
			let(:project) { FactoryGirl.create(:project) }
			xit "requires login" do
				delete :destroy, id: create(:project)
				expect(response).to redirect_to login_url
			end
		end

	end

end
