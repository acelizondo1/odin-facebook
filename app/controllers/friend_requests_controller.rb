class FriendRequestsController < ApplicationController
    before_action :set_friend_request, except: [:index, :create]

    def index
        @incoming = FriendRequest.where(friend: current_user)
        @pending = current_user.friend_requests
    end

    def create
        friend = User.find(params[:friend_id])
        @friend_request = current_user.friend_requests.new(friend: friend)
        
        if @friend_request.save
            friend.notifications.create(notifiable_id: @friend_request.id, notifiable_type: @friend_request.class.to_s)
            redirect_back(fallback_location: root_path)
        else
            flash[:alert] = "Error Sending Friend Request"
        end
    end

    def update 
        @friend_request.accept
        Notification.find_by(notifiable_id: @friend_request.id).destroy
        flash[:notice] = "Friend Request Accepted"
        redirect_back(fallback_location: root_path)
    end

    def destroy
        Notification.find_by(notifiable_id: @friend_request.id).destroy
        @friend_request.destroy
        redirect_back(fallback_location: root_path)
    end

    private

    def set_friend_request
        @friend_request = FriendRequest.find(params[:id])
    end
end
