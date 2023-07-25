require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Create Post data and check validation' do
    post = FactoryBot.create(:post)
    it 'check post is valid or not' do
      puts post.create_user_id
      # expect(post["title"]).to eq "Rspec"
    end

    it 'check post title without data' do
      post.title = nil
      expect(post).to_not be_valid
    end

  end
end
