class NotificationsController < ApplicationController
    before_action :set_notification, only: [:update, :destroy]

    def index
        @likes = Like.where("user_id = ?", current_user.id)
    end

    def create
        @notification = Notification.new(likes_params)
    end

    def update
        @like.update(:read => true)
    end

    def destroy
        @like.destroy
    end

    private

    def likes_params
        params.require(:like).permit(:user_id, :notifiable_id, :notifiable_type)
    end

    def set_notification
        @notification = Notification.find(params[:id])
    end
end
