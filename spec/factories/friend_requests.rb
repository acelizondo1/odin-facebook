FactoryBot.define do 
  factory :friend_request do 
    user 
    friend

    factory :friend_request_with_notification do
      after :create do |friend_request| 
        Notification.create!(user: friend_request.friend, notifiable_id: friend_request.id, notifiable_type: 'FriendRequest') 
      end
    end
  end
end