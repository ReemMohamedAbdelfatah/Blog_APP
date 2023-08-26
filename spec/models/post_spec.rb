# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_comments' do
    let(:post) { create(:post) }

    it 'returns up to 5 most recent comments' do
      older_comment = create(:comment, post: post, created_at: 4.days.ago)
      newer_comment = create(:comment, post: post, created_at: 2.days.ago)
      create(:comment, post: post, created_at: 3.days.ago)

      recent_comments = post.recent_comments

      expect(recent_comments.length).to eq(3)
      expect(recent_comments).to include(newer_comment)
      expect(recent_comments).to include(older_comment)
    end
  end

  describe '#update_posts_counter' do
    let(:user) { create(:user) }

    it 'updates the author\'s posts_counter' do
      post = create(:post, author: user)

      expect {
        post.update_posts_counter
        user.reload
      }.to change(user, :posts_counter).by(1)
    end
  end
end
