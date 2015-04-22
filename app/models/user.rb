class User < ActiveRecord::Base
	has_many :todos
	has_many :relationships, foreign_key: :follower_id
	has_many :leaders, through: :relationships
	has_many :followers, through: :relationships

	def following?(another_user)
		self.relationships.where(leader_id: another_user).first
	end

	def can_follow?(another_user)
		!(self.following?(another_user) || another_user == self)
	end
end
