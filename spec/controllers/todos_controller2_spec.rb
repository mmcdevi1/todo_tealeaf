require 'spec_helper' 

describe TodosController, type: :controller do 
  describe "GET index" do 
    it "sets the @todos variable" do 
      cook = Todo.create(name: "cook", description: "description")
      sleep = Todo.create(name: "sleep", description: "description")
      get :index
      expect(assigns(:todos)).to eq([cook, sleep])
    end

    it "renders the index template" do 
      get :index
      expect(response).to render_template(:index)
    end
  end 

  describe "GET new" do 
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

  describe "POST create" do 
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

    context "with invalid inputs" do 
      before do 
        post :create, todo: { name: "cook", description: "" }
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