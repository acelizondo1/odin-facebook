class RegistrationsController < Devise::RegistrationsController

    def create
        super
        if @user.persisted?
            RegistrationMailer.with(user: @user).registration_email.deliver
        end
    end    

    private
    def sign_up_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def account_update_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
    end
end
