require 'rails_helper'

RSpec.describe UsersController , type: :controller do
  #user_lists
  before(:each) do
    admin = User.find_by(id: 1)
    sign_in admin
  end

  context 'Get User lists from userscontroller' do    
    it 'Get all Users' do
      get :user_lists
      expect(response.status).to eq(200)
      result = controller.instance_variable_get("@users_list")
      # puts result.inspect
      expect(result.count).to eq(8)
    end
  end

  context "Get data and check with database" do
    it 'Get data and check' do 
      get :show , params: {
        id: 9
      }
      result = controller.instance_variable_get("@user")
      expect(result.email).to eq "myominkhant5647@gmail.com"
    end
  end

  context "Get data and create account" do
    it "check for confirm post" do
      user1 = FactoryBot.build(:user)
      post :confirm_post , params: {
        user: {
          name: user1.name,
          email: user1.email,
          password: user1.password,
          avatar: user1.avatar,
          role: user1.role,
          phone: user1.phone,
          address: user1.address,
          dob: user1.dob,
          create_user_id: user1.create_user_id,
          updated_user_id: user1.updated_user_id
        }
      }
      result = controller.instance_variable_get("@user")
      expect(response).to redirect_to users_confirm_users_path(user: user1.email)
    end
  end

  context "Get data and delete account" do
    it "check for acc_create" do
      total = User.all
      puts total.count
      post :acc_create , params: {
        id: 9
      }
      puts total.count
      expect(response.status).to eql(302)
      expect(response).to redirect_to users_user_lists_users_path
    end
  end

  context "Get data and update user account" do
    it "check for update" do
      put :update , params: {
        id: 9 ,
        user: {
          name: "Change User",
          email: "changeemail@gmail.com",
          role: 1,
          phone: 128934,
          address: "change address",
          dob: "1999-06-03",
          create_user_id: 3,
          updated_user_id: 3
        }
      }
      result = controller.instance_variable_get("@user")
      edit_data = controller.instance_variable_get("@wew")
      expect(response).to redirect_to user_path(result.id)
    end
  end

  context "Get data and soft delete user account" do
    it "check soft delete" do
      delete :soft_delete , params: {
        id: 9
      }
      expect(response).to redirect_to users_user_lists_users_path
    end
  end

  context "Get data and change password" do
    it "check password_update" do
      put :password_update , params: {
        id: 9 ,
        user: {
          old_password: "1234qwer",
          password: "1234asdf",
          password_confirmation: "1234asdf",
        }
      } 
      expect(response).to redirect_to users_user_lists_users_path
    end
  end
end
