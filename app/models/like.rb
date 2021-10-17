class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post

    has_many :notifications, :as => :notifiable, dependent: :destroy

    scope :locate_like, ->(user_id, post_id){where("user_id = ? AND post_id = ?", user_id, post_id)}
end
