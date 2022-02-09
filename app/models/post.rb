class Post < ApplicationRecord
  has_paper_trail

  include Discard::Model

  # extend FriendlyId

  # friendly_id :title, use: :slugged

  validates :title, presence: true

  belongs_to :user

  has_many :comments, as: :commentable

  has_rich_text :content

  resourcify
end
