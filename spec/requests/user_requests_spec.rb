require 'rails_helper'

RSpec.describe UsersController , type: :controller do
  #user_lists
  context 'Get User lists from userscontroller' do
    it 'Get all Users' do
      admin = FactoryBot.build(:user)
      sign_in admin
      get :user_lists
      expect(response.status).to eq(200)
      json = JSON.parse(response.body)
      # total user is 19 and 7 are deleted = 12
      expect(json.count).to eq(12)
    end
  end
end
