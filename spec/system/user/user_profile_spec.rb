require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Users', type: :system do

    feature 'Profile' do
        subject(:user) {FactoryBot.create(:user, :with_avatar)}
        
        given!(:post_1) {FactoryBot.create(:post, user: user)}
        given!(:post_2) {FactoryBot.create(:post)}

        background(:each) do 
            sign_in(user)
            visit user_path(user)
        end

        scenario 'shows logged in user info' do
            within '#user-profile' do
                expect(page.find('img')['src']).to have_content('test_image.png')
                expect(page.find('h3')).to have_content(user.name)
                expect(page).to have_content(user.email)
            end
        end

        scenario 'shows all posts by User' do
            expect(page).to have_content(post_1.body)
        end

        scenario 'does not show posts by other users' do
            expect(page).to_not have_content(post_2.body)
        end

        scenario 'edits user information' do
            click_link 'edit-profile'
            fill_in 'user_email', with: 'new_email@test.com'
            click_button 'Update'
            expect(User.find_by(name: user.name).email).to eq('new_email@test.com')
        end

        scenario 'edits user password' do
            click_link 'edit-profile'
            fill_in 'user_password', with: 'password'
            fill_in 'user_password_confirmation', with: 'password'
            click_button 'Change Password'
            expect(User.find_by(name: user.name).valid_password?('password')).to be true
        end

        scenario 'updates user avatar' do
            click_link 'edit-profile'
            find('input', {class: 'file-input', visible: false}).set(Rails.root + 'spec/support/assets/test_image_2.png')
            within '#user-profile' do
                expect(page.find('img')['src']).to have_content('test_image_2.png')
            end   
        end
    end

end