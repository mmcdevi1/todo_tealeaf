require 'rails_helper'

describe RelationshipsController do
	let(:user) { FactoryGirl.create(:user) }
	let(:bob)  { FactoryGirl.create(:user) }
	let(:ali)  { FactoryGirl.create(:user) }

	describe "GET index" do 
		before do 
			session[:user_id] = user.id
		end

		it "assigns the @relationships variable" do 
			relationship = Relationship.create(leader_id: bob.id, follower_id: user.id)
			get :index
			expect(assigns(:relationships)).to eq([relationship])
		end
	end

	describe "POST create" do 
		context "authenticated users" do 
			before do 
				session[:user_id] = user.id
			end

			it "creates a relationship" do 
				post :create, leader_id: bob.id 
				expect(user.relationships.last.leader).to eq(bob)
			end

			it "redirects to the index page" do 
				post :create, leader_id: bob.id 
				expect(response).to redirect_to relationships_path
			end

			it "does not allow users to follow a user that they are already following" do 
				relationship = Relationship.create(leader_id: bob.id, follower_id: user.id)
				post :create, leader_id: bob.id 
				expect(Relationship.count).to eq(1)
			end

			it "does not allow users to follow themselves" do 
				post :create, leader_id: user.id 
				expect(Relationship.count).to eq(0)
			end
		end
	end

	describe "POST delete" do 
		let(:relationship) { Relationship.create(leader_id: bob.id, follower_id: user.id) }

		before do 
			session[:user_id] = user.id
			delete :destroy, id: relationship
		end

		it "redirects back to the index page" do 
			expect(response).to redirect_to relationships_path
		end

		it "allows users to unfollow" do 
			expect(Relationship.count).to eq(0)
		end

		it "does not allow a user to destroy a relationship that they are not a part of" do 
			relationship = Relationship.create(follower_id: ali.id, leader_id: bob.id)
			delete :destroy, id: relationship
			expect(Relationship.count).to eq(1)
		end
	end
end








































