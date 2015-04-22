# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do 
  User.create(
	  username: Faker::Internet.user_name + rand(1..1000).to_s,
	  full_name: Faker::Name.name,
	  email: Faker::Internet.email,
	  admin: false
	)
end