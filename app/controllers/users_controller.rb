class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :current_user?, only: [:show]

    def index
        @users = User.all
    end

    def show
        @user = current_user
    end

    private
    def current_user?
        unless params[:id].to_i == current_user.id
            flash[:alert] = "You can only access your own profile page"
            redirect_to root_path
        end
    end
end
