class AppMailer < ActionMailer::Base
	def notify_on_new_todo(user, todo)
		@todo = todo
		mail from: "info@todo.com", to: user.email, subject: "You created a new todo!"
	end
end