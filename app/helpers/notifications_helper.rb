module NotificationsHelper
    def find_view(type)
        case type
        when 'FriendRequest'
            'friend_request'
        when 'Like'
            'like'
        when 'Comment'
            'comment'
        end
    end
end
