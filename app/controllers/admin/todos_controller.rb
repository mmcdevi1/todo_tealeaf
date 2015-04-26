class Admin::TodosController < AdminsController
	def index
		@todos = Todo.all
	end
end