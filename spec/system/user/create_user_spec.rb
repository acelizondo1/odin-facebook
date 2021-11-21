require 'rails_helper'

RSpec.describe 'user creation', type: :system do

    feature "Creating account" do

        scenario 'succeeds with valid data' do
            visit new_user_registration_path

            fill_in 'Name', with: 'Test User'
            fill_in 'Email', with: 'user@example.com'
            fill_in 'Password', with: 'password'
            fill_in 'Password Confirmation', with: 'password'
            
            click_button 'Sign up'
            expect(page).to have_content 'Welcome! You have signed up successfully.'
        end

        scenario 'fails with invalid password' do 
            visit new_user_registration_path

            fill_in 'Name', with: 'Test User'
            fill_in 'Email', with: 'user@example.com'
            fill_in 'Password', with: '12345'
            fill_in 'Password Confirmation', with: '12345'
            
            click_button 'Sign up'
            expect(page).to have_content 'Password is too short (minimum is 6 characters)'
        end 
        
        scenario 'fails with duplicate email' do 
            FactoryBot.create(:user, email:'user@example.com')
            visit new_user_registration_path
            
            fill_in 'Name', with: 'Test User'
            fill_in 'Email', with: 'user@example.com'
            fill_in 'Password', with: 'password'
            fill_in 'Password Confirmation', with: 'password'
            
            click_button 'Sign up'
            expect(page).to have_content 'Email has already been taken'
        end 

        scenario 'uploads avatar image' do
            visit new_user_registration_path
            within 'form' do
                fill_in 'Name', with: 'Test User'
                fill_in 'Email', with: 'user@example.com'
                fill_in 'Password', with: 'password'
                fill_in 'Password Confirmation', with: 'password'

                find('input', {id: 'user_avatar', visible: false}).set(Rails.root + 'spec/support/assets/test_image.png')

                click_button 'Sign up'
            end

            expect(page).to have_content 'Welcome! You have signed up successfully.'
            user = User.find_by(email: 'user@example.com')
            expect(user.avatar.attached?).to be true
        end
    end
end