class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comment, only: [:show, :edit, :update, :destroy]

    def new
        @comment = @post.comments.build
    end

    def create
        @comment = @post.comments.build(user_id: current_user.id, body: post_params[:body])

        if @comment.save
            flash[:notice] = 'Comment Posted!'
            redirect_back(fallback_location: root_path)
        else
            flash[:alert] = 'There was an issue posting your comment. Please try again.'
            redirect_back(fallback_location: root_path)
        end
    end

    def show
    end

    def edit
    end

    def update
        if @comment.update(post_params)
            flash[:notice] = 'Your comment was successfully updated'
            redirect_to post_path(params[:post_id])
        else
            flash[:alert] = 'Your comment could not be updated at this time. Please try again.'
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        if @comment.destroy
            flash[:notice] = 'Your comment was deleted.'
            redirect_back(fallback_location: root_path)
        else 
            flash[:alert] = 'There was an issue deleting your comment. Please try again.'
            redirect_back(fallback_location: root_path)
        end
    end

    private

    def post_params
        params.permit(:body)
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def set_post  
        @post = Post.find(params[:post_id])
    end
end
