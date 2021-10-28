class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :suggested_users

    def suggested_users
        @suggest_users = User.left_outer_joins(:friendships).where('NOT users.id = ? AND (NOT friendships.friend_id = ? OR friendships.friend_id IS NULL)', current_user.id, current_user.id).order('RANDOM()').limit(5)
    end
end
