class Friendship < ApplicationRecord
    after_create :create_inverse_relationship
    after_destroy :destroy_inverse_relationship

    validate :not_self
  
    belongs_to :user
    belongs_to :friend, class_name: 'User'

    scope :locate_friendship, ->(user_id, friend_id){where("user_id = ? AND friend_id = ?", user_id, friend_id)}

    def remove_friend
        user.friends.destroy(friend)
    end
  
    private
  
    def create_inverse_relationship
        unless !Friendship.where("user_id = ? AND friend_id = ?", friend.id, user.id).empty?
            friend.friendships.create(friend: user) 
        end
    end
  
    def destroy_inverse_relationship
        friendship = friend.friendships.find_by(friend: user)
        friendship.destroy if friendship
    end

    def not_self
        errors.add(:friend, "can't be equal to user") if user == friend
    end
end
