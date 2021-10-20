module NotificationsHelper
    def generate_view(notification)
        case notification.notifiable_type
        when 'FriendRequest'
            request = FriendRequest.find(notification.notifiable_id)
            {
                request: request,
                message: "sent you a friend request.",
                button: "Respond",
                path: friend_requests_path
            }
        when 'Like'
            request = Like.find(notification.notifiable_id)
            {
                request: request,
                message: "liked your post.",
                button: "View",
                path: post_path(request.post_id)
            }
        when 'Comment'
            request = Comment.find(notification.notifiable_id)
            {
                request: request,
                message: "commented on your post.",
                button: "View",
                path: post_path(request.post_id)
            }
        end
    end
end
