require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Users', type: :system do

    feature 'Find Friends' do
        given!(:user_1) {FactoryBot.create(:user)}
        given!(:user_2) {FactoryBot.create(:user)}
        given(:user_3) {FactoryBot.create(:user)}
 
        background(:each) do 
            sign_in(user_1)
        end

        scenario 'able to see all users' do
           visit users_path 
           
           expect(page.find_all(:css, '.user').size).to eq(User.all.size-1)
        end

        scenario 'able to send friend request' do
            visit users_path

            within "#user-#{user_2.id}" do
                click_on 'Add Friend'
            end
            expect(page).to have_link 'Delete Request'
        end

        scenario 'able to unsend friend request' do
            visit users_path
            within "#user-#{user_2.id}" do
                click_on 'Add Friend'
                click_on 'Delete Request'
                expect(page).to have_link 'Add Friend'
            end
        end

        scenario 'only sees unfriended users' do 
            Friendship.create!(user:user_1, friend: user_3)

            visit users_path
            within '.is-6' do
                expect(page).to have_selector 'p', text: user_2.name
                expect(page).to_not have_selector 'p', text: user_3.name
            end
        end 

    end
end
