class AdminsController < AuthenticateController
	before_action :authenticate_admin

	def authenticate_admin
		redirect_to root_path unless current_user.admin?
	end
end