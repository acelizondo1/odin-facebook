module ApplicationHelper
    def avatar_select(user, size)
        if user.avatar.attached?
            user.avatar.variant(resize_to_fill: size)
        else
            'https://bulma.io/images/placeholders/128x128.png'
        end
    end

    def choose_root
        user_signed_in? ? authenticated_root_path : unauthenticated_root_path
    end
end
