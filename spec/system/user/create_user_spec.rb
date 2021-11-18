require 'rails_helper'

RSpec.describe 'user creation', type: :system do

    feature "Creating account" do

        scenario 'creates account with valid data' do
            visit new_user_registration_path

            fill_in 'Name', with: 'Test User'
            fill_in 'Email', with: 'user@example.com'
            fill_in 'Password', with: 'password'
            fill_in 'Password Confirmation', with: 'password'
            
            click_button 'Sign Up'
            expect(page).to have_content 'Welcome! You have signed up successfully!'
        end


    end
end