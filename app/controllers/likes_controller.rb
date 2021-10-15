class LikesController < ApplicationController
    before_action :set_like, only: [:destroy]

    def create

    end

    def destroy 

    end

    private 
    def set_like
        @like = Like.find(params[:id])
    end
end
