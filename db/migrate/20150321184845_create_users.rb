class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :full_name
      t.string :email
      t.boolean :admin

      t.timestamps
    end
  end
end
