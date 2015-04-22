class AddTokenToTodos < ActiveRecord::Migration
  def change
    add_column :todos, :token, :string

    Todo.all.each do |todo|
    	todo.token = SecureRandom.urlsafe_base64
    	todo.save
    end
  end
end
