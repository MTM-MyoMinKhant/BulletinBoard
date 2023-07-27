require 'rails_helper'

RSpec.describe PostsController , type: :controller do
  before(:each) do
    admin = User.find_by(id: 1)
    sign_in admin
  end

  context "Get data and check with database" do
    it "check for index" do
      @post = Post.all()
      expect(@post.count).to eq(27)
      expect(response.status).to eq(200)
    end
  end

  context "Check validation and send to another method" do
    it "check for confirm_post" do
      
      post :confirm_post , params: {
        post: {
          title: "Naruto Storm 4",
          description: "Online PvP",
          status: 1,
          create_user_id: 3,
          updated_user_id: 3,
        }
      }
      # expect(response.status).to eq(422)
      expect(response.status).to eq(302)  
      # expect(response).to redirect_to posts_confirm_posts_path(post: {
      #   title: params[:post][:title],
      #   description: params[:post][:description],
      #   status: params[:post][:status],
      #   create_user_id: params[:post][:create_user_id],
      #   updated_user_id: params[:post][:updated_user_id]
      # })
    end
  end
  
  context "Get data and create post" do
    it "check create" do
      post :create , params: {
        post: {
          title: "Naruto Storm 4",
          description: "Online PvP",
          status: 1,
          create_user_id: 3,
          updated_user_id: 3,
        }
      }
      expect(response.status).to eq(302)
      expect(response).to redirect_to posts_path
    end
  end

  context "Get single data and check with database" do
    it "check edit" do
      get :edit , params: {
        id: 9
      }
      result = controller.instance_variable_get("@post")
      expect(result.title).to eq("System Shock")
      expect(response.status).to eq(200)
    end
  end

  context "Check edit data validation and send to another method" do
    it "check edit_confirm_post" do
      post :edit_confirm_post , params: {
        id: 9,
        post: {
          title: "Naruto Storm 4",
          description: "Online PvP",
          status: 1,
          create_user_id: 3,
          updated_user_id: 3,
        }
      } 
      expect(response.status).to eq(302)
    end
  end

  context "Get Data and update in database" do
    it "check update" do
      put :update , params: {
        id: 9,
        post: {
          title: "Naruto Storm 4",
          description: "Online PvP",
          status: 1,
          create_user_id: 3,
          updated_user_id: 3,
        }
      }
      expect(response).to redirect_to posts_path
    end
  end
  
  context "Get Data and soft delete" do
    it "check soft_delete" do
      delete :soft_delete , params: {
        id: 9,
        delete_id: 1,
      }
      expect(response.status).to redirect_to posts_path
    end
  end
end
