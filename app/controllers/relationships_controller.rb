class RelationshipsController < ApplicationController
	before_action :authenticate_user

	def index
		@relationships = current_user.relationships
	end

	def create
		leader = User.find(params[:leader_id])
		relationship = current_user.relationships.new(leader_id: params[:leader_id])
		relationship.save if current_user.can_follow?(leader)
		redirect_to relationships_path
	end

	def destroy
		relationship = Relationship.find(params[:id])
		relationship.destroy if current_user == relationship.follower
		flash[:success] = "Unfollowed"
		redirect_to relationships_path
	end

end
