require 'spec_helper'

describe TodosController, type: :controller do
  describe "GET index" do
    it "assigns all todos as @todos" do
      cook = Todo.create(name: "cook", description: "description")
      fart = Todo.create(name: "fart", description: "description")
      get :index
      expect(assigns(:todos)).to eq([cook, fart])
    end

    it "renders the index template" do 
      get :index
      expect(response).to render_template :index
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
    it "creates the todo record when the input is valid" do 
      post :create, todo: { name: "cook", description: "I like cooking" }
      expect(Todo.first.name).to eq("cook")
      expect(Todo.first.description).to eq("I like cooking")
    end 

    it "redirects to the root path when the input is valid" do 
      post :create, todo: { name: "cook", description: "I like cooking" }
      expect(response).to redirect_to root_path
    end

    it "does not create a todo when the input is invalid" do
      post :create, todo: {description: "I like cooking!" }
      expect(Todo.count).to eq(0)
    end

    it "renders the new template when the input is invalid" do
      post :create, todo: {description: "I like cooking!" }
      expect(response).to render_template :new
    end

    it "does not create tags without inline locations" do 
      post :create, todo: { name: "cook", description: "I like cooking" }
      expect(Tag.count).to eq(0)
    end

    it "does not create tags with at in a word" do 
      post :create, todo: { name: "eat an apple", description: "eat an opple" }
      expect(Tag.count).to eq(0)
    end

    it "creates a tag with upcase AT" do 
      post :create, todo: { name: "shop AT the apple store", description: "apple store" }
      expect(Tag.all.map(&:name)).to eq(["location:the apple store"])
    end

    context "with inline locations" do 
      it "creates a tag with one location" do 
        post :create, todo: { name: "cook AT home", description: "I like cooking" }
        expect(Tag.all.map(&:name)).to eq(["location:home"])
      end

      it "creates two tags with two locations" do 
        post :create, todo: { name: "cook AT home and work", description: "I like cooking" }
        expect(Tag.all.map(&:name)).to eq(["location:home", "location:work"])
      end

      it "creates multiple tags with four locations" do 
        post :create, todo: { name: "cook AT home, work, school and library", description: "I like cooking" }
        expect(Tag.all.map(&:name)).to eq(["location:home", "location:work", "location:school", "location:library"])
      end
    end
  end

end
