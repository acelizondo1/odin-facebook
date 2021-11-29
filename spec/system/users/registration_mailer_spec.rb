require 'rails_helper'

feature "Send Welcome Email" do
    let(:user) {FactoryBot.build(:user)}
    
    it 'sends a valid welcome email when account is created' do
        visit new_user_registration_path

        fill_in 'Name', with: user.name
        fill_in 'Email', with: user.email
        fill_in 'Password', with: 'password'
        fill_in 'Password Confirmation', with: 'password'

        click_button 'Sign up'

        welcome_mailer = ActionMailer::Base.deliveries.last
        expect(welcome_mailer.to).to include(user.email)
    end
end