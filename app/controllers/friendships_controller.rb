class FriendshipsController < ApplicationController

    def create 
        friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id])
        
        respond_to do |format|
            if friendship.save
                format.html{redirect_back(fallback_location: root_path)}
            else
                format.html{redirect_back(fallback_location: root_path)}
            end
        end

    end

    def destroy 
        friendship = Friendship.locate_friendship(params[user_id], params[friend_id])
        respond_to do |format|
            if friendship.destroy
                format.html{redirect_back(fallback_location: root_path)}
            else
                format.html{redirect_back(fallback_location: root_path)}
            end
        end

    end
end
