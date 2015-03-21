require 'spec_helper'

describe Todo do

  describe "#name_only?" do 
    it "returns true if the description is nil" do 
      todo = Todo.new(name: "cook dinner")
      todo.should be_name_only
    end

    it "returns true if the description is an empty string" do 
      todo = Todo.new(name: "cook dinner", description: "")
      todo.should be_name_only
    end

    it "returns false if the description is a non empty string" do 
      todo = Todo.new(name: "cook dinner", description: "something")
      todo.should_not be_name_only
    end
  end

  describe "#display_text" do 
    let(:todo) { FactoryGirl.create(:todo) }
    let(:subject) { todo.display_text }

    context "no tags" do 
      it { should eq("cook dinner") }
    end
    
    context "one tag" do
      before do 
        todo.tags.create(name: "home")
      end
      it { should eq("cook dinner (tag: home)") }
    end

    context "multiple tags" do 
      before do 
        todo.tags.create(name: "home")
        todo.tags.create(name: "urgent")
      end
      it { should eq("cook dinner (tags: home, urgent)") }
    end

    context "more than four tags" do 
      before do 
        todo.tags.create(name: "home")
        todo.tags.create(name: "urgent")
        todo.tags.create(name: "help")
        todo.tags.create(name: "book")
        todo.tags.create(name: "patience")
      end
      it { should eq("cook dinner (tags: home, urgent, help, book, more...)") }
    end
  end

end
















































