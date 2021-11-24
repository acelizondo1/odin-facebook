class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  has_one_attached :photo, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
end
