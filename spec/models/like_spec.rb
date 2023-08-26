# spec/models/like_spec.rb
require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe '#update_likes_counter' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it 'updates the post\'s likes_counter' do
      like = create(:like, author: user, post: post)

      expect {
        like.update_likes_counter
        post.reload
      }.to change(post, :likes_counter).by(1)
    end
  end
end
