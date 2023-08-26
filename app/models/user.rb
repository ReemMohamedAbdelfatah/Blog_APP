class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  attribute :name, :string
  attribute :photo, :string
  attribute :bio, :text
  attribute :Posts_Counter, :integer, default: 0

  validates :name, presence: true
  validates :Posts_Counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
