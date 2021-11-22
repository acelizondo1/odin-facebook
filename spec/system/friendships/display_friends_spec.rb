require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Friendshps', type: :system do

    feature 'Display Friends' do
        given!(:user) {FactoryBot.create(:user)}
        given!(:user_2) {FactoryBot.create(:user)}

        let(:friendship_1) {FactoryBot.create(:friendship, user: user, friend: user_2)}
        let(:friend_request) {FactoryBot.create(:friend_request, user: user, friend: user_2)}

        background(:each) do 
            sign_in(user)
        end

        scenario 'shows no friends message' do
            visit friendships_path
            expect(page).to have_content('No friends to display')
        end

        scenario 'shows current friends' do 
            friendship_1

            visit friendships_path
            within '#user-friends' do
                expect(page).to have_content(user_2.name)
            end
        end

        scenario 'does not show users with pending friend requests' do
            friend_request

            visit friendships_path
            within '#user-friends' do
                expect(page).to_not have_content(user_2.name)
            end
        end

        scenario 'unfriends user' do
            friendship_1

            visit friendships_path
            within '.friend-card' do
                accept_confirm do
                    click_link 'Unfriend'
                end
            end
            expect(page).to have_content('No friends to display')
        end

    end

end