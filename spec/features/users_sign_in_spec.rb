require 'rails_helper'

feature "user signs in" do 
	let!(:user) { FactoryGirl.create(:user) }
	scenario "with existing username" do 
		visit root_path
		fill_in "Username", with: "mmcdevi1"
		click_button "Sign in"
		expect(page).to have_content("Michael")
	end
end