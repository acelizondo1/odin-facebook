class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :check_access, only: [:show, :edit, :update, :destroy]

    def index
        @post_friend = true
        @post = Post.new
        @posts = Post.joins('LEFT JOIN "friendships" ON "friendships"."user_id" = "posts"."user_id"').includes(:user).distinct.where("posts.user_id = ? OR friendships.friend_id = ?", current_user.id, current_user.id).order(updated_at: :desc).limit(10)
    end

    def user
        @post_friend = true
        @posts = Post.where("user_id = ?", current_user.id)
    end

    def new 
        @post = Post.new
    end

    def show
    end

    def edit 
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            flash[:notice] = 'Status Posted!'
            render 'show'
        else
            flash[:alert] = 'There was an issue posting. Please try again.'
            redirect_back(fallback_location: root_path)
        end
    end

    def update 
        if @post.update(post_params)
            flash[:notice] = 'Your post was successfully updated'
            render 'show'
        else
            flash[:alert] = 'Your post could not be updated at this time. Please try again.'
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy 
        if @post.destroy
            flash[:notice] = 'Your post was deleted.'
            redirect_to root_path
        else 
            flash[:alert] = 'There was an issue deleting your post. Please try again.'
            redirect_back(fallback_location: root_path)
        end

    end

    private

    def post_params
        params.require(:post).permit(:body, :photo)
    end

    def set_post
        @post = Post.find(params[:id])
    end

    def check_access 
        if @post.user.friends.include?(current_user) || @post.user == current_user
            @post_friend = true
        else
            @post_friend = false
            unless action_name == 'show'
                flash[:alert] = 'You cannot edit this post!'
                redirect_to post_path(@post)
            end
        end
    end
end
