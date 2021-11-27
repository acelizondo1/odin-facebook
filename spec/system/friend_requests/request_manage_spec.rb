require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Friend Requests', type: :system do

    feature 'Respond to requests' do

        given!(:user) {FactoryBot.create(:user)}
        given!(:user_2) {FactoryBot.create(:user)}
        given!(:user_3) {FactoryBot.create(:user)}

        given(:friend_request_1) {FactoryBot.create(:friend_request_with_notification, user: user, friend: user_2)}
        given(:friend_request_2) {FactoryBot.create(:friend_request_with_notification, user: user_3, friend: user)}

        background(:each) do 
            sign_in(user)
        end

        scenario 'displays empty messages if no requests are pending' do
            visit friend_requests_path
            expect(page).to have_content('You have no new friend requests!')
            expect(page).to have_content('No pending requests. Go out and find new friends!')
        end

        scenario 'displays pending requests' do
            friend_request_1
            visit friend_requests_path
            within '#pending-requests' do
                expect(page).to have_content(friend_request_1.friend.name)
            end
        end
        
        scenario 'displays incoming requests' do
            friend_request_2
            visit friend_requests_path
            within '#incoming-requests' do
                expect(page).to have_content(friend_request_2.user.name)
            end
        end

        scenario 'accepts incoming request' do
            friend_request_2
            
            visit friend_requests_path
            within '#incoming-requests' do
                click_link 'Accept'
                expect(page).to_not have_content(friend_request_2.user.name)
                expect(user.friends.size).to eq(1)
            end
            expect(page).to have_content('Friend Request Accepted')
        end

        scenario 'declines incoming request' do
            friend_request_2
            visit friend_requests_path
            within '#incoming-requests' do
                click_link 'Decline'
                expect(page).to_not have_content(friend_request_2.user.name)
            end
        end

        scenario 'revokes pending sent requests' do
            friend_request_1
            visit friend_requests_path
            within '#pending-requests' do
                click_link 'Delete Request'
                expect(page).to_not have_content(friend_request_1.friend.name)
            end
        end

    end
end
