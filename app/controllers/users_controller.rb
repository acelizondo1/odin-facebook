class UsersController < ApplicationController
    before_action :current_user?, only: [:show]

    def index
        @users = User.left_outer_joins(:friendships).where('NOT users.id = ? AND (NOT friendships.friend_id = ? OR friendships.friend_id IS NULL)', current_user.id, current_user.id)
    end

    def show
        @user = current_user
    end

    def edit
        @user = current_user 
    end

    def update
        if current_user.update(user_params)
            flash[:notice] = "Successfully updated your profile"
            redirect_to current_user
        else
            flash[:alert] = "There was an error updating your profile"
        end
    end

    def suggest
        @suggest_users = User.left_outer_joins(:friendships).where('NOT users.id = ? AND (NOT friendships.friend_id = ? OR friendships.friend_id IS NULL)', current_user.id, current_user.id)
    end

    private
    def current_user?
        unless params[:id].to_i == current_user.id
            flash[:alert] = "You can only access your own profile page"
            redirect_to root_path
        end
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end 
end
