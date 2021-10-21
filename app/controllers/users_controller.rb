class UsersController < ApplicationController
    before_action :current_user?, only: [:show]

    def index
        @users = User.left_outer_joins(:friendships).where('NOT friendships.friend_id = ? OR users.id = ?', current_user.id, current_user.id)
    end

    def show
        @user = current_user
    end

    def edit 
    end

    def update
        
    end

    def suggest
        @suggest_users = User.all#left_outer_joins(:friendships).where('NOT friendships.friend_id = ? OR NOT users.user_id = ?', current_user.id, current_user.id)
    end

    private
    def current_user?
        unless params[:id].to_i == current_user.id
            flash[:alert] = "You can only access your own profile page"
            redirect_to root_path
        end
    end
end
