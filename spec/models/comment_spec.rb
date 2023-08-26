# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post) }
  end

  describe '#update_comments_counter' do
    let(:user) { create(:user) }
    let(:post) { create(:post) }

    it 'updates the post\'s comments_counter' do
      comment = create(:comment, author: user, post: post)

      expect {
        comment.update_comments_counter
        post.reload
      }.to change(post, :comments_counter).by(1)
    end
  end
end
