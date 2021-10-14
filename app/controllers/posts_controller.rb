class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index
        @post = Post.new
        @posts = Post.includes(:user).order(updated_at: :desc).limit(10)
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
            redirect_back(fallback_location: root_path)
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
            redirect_back(fallback_location: root_path)
        else 
            flash[:alert] = 'There was an issue deleting your post. Please try again.'
            redirect_back(fallback_location: root_path)
        end

    end

    private

    def post_params
        params.require(:post).permit(:body)
    end

    def set_post
        @post = Post.find(params[:id])
    end
end
