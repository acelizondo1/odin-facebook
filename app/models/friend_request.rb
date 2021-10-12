class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name:'User'

  scope :locate_request, ->(user_id, friend_id){where("user_id = ? AND friend_id = ?", user_id, friend_id)}

  def accept 
    user.friends << friend
    destroy
  end
end
