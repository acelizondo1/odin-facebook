class LikesController < ApplicationController
    before_action :set_like, only: [:destroy]

    def index 
        @likes = Like.includes(:post).where("user_id = ?", current_user.id)
    end

    def create
        post = Post.find(params[:post_id])
        @like = current_user.likes.new(post: post)

        if @like.save
            redirect_back(fallback_location: root_path)
        else
            flash[:alert] = "Error liking this post."
        end
    end

    def destroy 
        @like.destroy
        redirect_back(fallback_location: root_path)
    end

    private 
    def set_like
        @like = Like.find(params[:id])
    end
end
