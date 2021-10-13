class FriendshipsController < ApplicationController
    before_action :set_friendship, only: [:destroy]

    def index 
        @friends = current_user.friends
    end

    def destroy
        @friendship.remove_friend
        redirect_back(fallback_location: root_path)
    end

    private

    def set_friendship
        @friendship = Friendship.find(params[:id])
    end
end
