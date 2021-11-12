class RegistrationMailer < ApplicationMailer
    default from: ENV['confirmation_email']

    def registration_email
        @user = params[:user]
        @url = ENV['confirmation_url']
        mail(to: @user.email, subject: 'Welcome to Odin-Facebook!')
    end
end
