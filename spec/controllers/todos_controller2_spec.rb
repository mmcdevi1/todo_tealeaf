require 'spec_helper' 

describe TodosController, type: :controller do 
  let(:user) { FactoryGirl.create(:user) }

  describe "GET index" do 
    context "with authenticated user" do
      before { set_current_user }
      it "sets the @todos variable" do 
        cook = current_user.todos.create(name: "cook", description: "description")
        sleep = current_user.todos.create(name: "sleep", description: "description")
        get :index
        expect(assigns(:todos)).to eq([cook, sleep])
      end

      it "renders the index template" do 
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "with unauthenticated user" do
      before { get :index }
      it_behaves_like "require_sign_in"
    end
  end 

  describe "GET new" do 
    context "with authenticated user" do
      before { set_current_user }
      it "sets the @todo variable" do 
        get :new
        expect(assigns(:todo)).to be_new_record
        expect(assigns(:todo)).to be_instance_of(Todo)
      end

      it "renders the new template" do 
        get :new
        expect(response).to render_template :new
      end
    end 

    context "with unauthenticated user" do 
      before { get :new }
      it_behaves_like "require_sign_in"
    end
  end

  describe "POST create" do 
    before do 
      session[:user_id] = user.id
    end

    context "with valid inputs" do 
      before do 
        post :create, todo: { name: "cook", description: "description" }
      end

      it "creates a new todo record when the input is valid" do 
        expect(Todo.first.name).to eq("cook")
        expect(Todo.first.description).to eq("description")
        expect(Todo.count).to eq(1)
      end

      it "redirects to the root path when the input is valid" do 
        expect(response).to redirect_to root_path
      end
    end

    context "email sending" do 
      before do 
        post :create, todo: { name: "cook", description: "description" }
      end

      it "sends out the email" do 
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it "sends to the right recipient" do 
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([user.email])
      end

      it "sends out the right content" do 
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to have_content("#{Todo.last.name}")
      end
    end

    context "with invalid inputs" do 
      before do 
        post :create, todo: { name: "" }
      end

      it "does not create a todo when the input is invalid" do 
        expect(Todo.count).to eq(0)
      end

      it "renders the new template if input is invalid" do 
        expect(response).to render_template :new
      end
    end
  end
end









































