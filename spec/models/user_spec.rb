require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Check validation for the factory Data' do
    user = FactoryBot.build(:user)

    it "Check the user data is not valid or not" do
      puts user.name
      expect(user).to be_valid
    end

    it "Check the user phone number is valid or not" do
      puts user.phone
      user.phone = nil
      expect(user.valid?).to eq false
    end
  end
end
