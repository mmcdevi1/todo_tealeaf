shared_examples "require_sign_in" do 
	it "redirects to the front page" do 
		expect(response).to redirect_to root_path
	end
end