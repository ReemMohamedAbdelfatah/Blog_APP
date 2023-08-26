# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy).with_foreign_key('author_id') }
    it { should have_many(:comments).dependent(:destroy).with_foreign_key('author_id') }
    it { should have_many(:likes).dependent(:destroy).with_foreign_key('author_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:posts_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#recent_posts' do
    let(:user) { create(:user) }

    it 'returns up to 3 most recent posts' do
      older_post = create(:post, author: user, created_at: 4.days.ago)
      newer_post = create(:post, author: user, created_at: 2.days.ago)
      create(:post, author: user, created_at: 3.days.ago)

      recent_posts = user.recent_posts

      expect(recent_posts.length).to eq(3)
      expect(recent_posts).to include(newer_post)
      expect(recent_posts).to include(older_post)
    end
  end
end
