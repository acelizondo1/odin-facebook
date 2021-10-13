class PostsController < ApplicationController
    before_action :set_post, only: [:edit, :update, :destroy]

    def index 
        @posts = Post.includes(:user).limit(10)
    end

    def new 
        @post = Post.new
    end

    def create

    end

    def edit 

    end

    def update 

    end

    def destroy 

    end

    private

    def set_post
        @post = Post.find(params[:id])
    end
end
