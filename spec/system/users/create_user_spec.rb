require 'rails_helper'

RSpec.describe 'user creation', type: :system do

    feature "Creating account" do
        let(:user) {FactoryBot.build(:user)}

        scenario 'succeeds with valid data' do
            visit new_user_registration_path

            fill_in 'Name', with: user.name
            fill_in 'Email', with: user.email
            fill_in 'Password', with: 'password'
            fill_in 'Password Confirmation', with: 'password'
            
            click_button 'Sign up'
            expect(page).to have_content 'Welcome! You have signed up successfully.'
        end

        scenario 'fails with invalid password' do 
            visit new_user_registration_path

            fill_in 'Name', with: user.name
            fill_in 'Email', with: user.email
            fill_in 'Password', with: '12345'
            fill_in 'Password Confirmation', with: '12345'
            
            click_button 'Sign up'
            expect(page).to have_content 'Password is too short (minimum is 6 characters)'
        end 
        
        scenario 'fails with duplicate email' do 
            created_user = FactoryBot.create(:user)
            visit new_user_registration_path
            
            fill_in 'Name', with: 'Duplicate User'
            fill_in 'Email', with: created_user.email
            fill_in 'Password', with: 'password'
            fill_in 'Password Confirmation', with: 'password'
            
            click_button 'Sign up'
            expect(page).to have_content 'Email has already been taken'
        end 

        scenario 'uploads avatar image' do
            visit new_user_registration_path
            within 'form' do
                fill_in 'Name', with: user.name
                fill_in 'Email', with: user.email
                fill_in 'Password', with: 'password'
                fill_in 'Password Confirmation', with: 'password'

                find('input', {id: 'user_avatar', visible: false}).set(Rails.root + 'spec/support/assets/test_image.png')

                click_button 'Sign up'
            end

            expect(page).to have_content 'Welcome! You have signed up successfully.'
            signed_in_user = User.find_by(email: user.email)
            expect(signed_in_user.avatar.attached?).to be true
        end
    end
end