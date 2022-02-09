class Comment < ApplicationRecord
  has_paper_trail

  include Discard::Model

  belongs_to :user

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  has_rich_text :content

  resourcify

  validates :content, presence: true
end
