require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Notifications', type: :system do

    feature 'Display Notification' do
        let(:user_1) {FactoryBot.create(:user_with_post)}
        let(:user_2) {FactoryBot.create(:user)}

        background(:each) do
            sign_in(user_2)
        end

        scenario 'empty message with no notifications present' do
            visit notifications_path

            expect(page).to have_content('You have no new notifications')
        end

        scenario 'for new incoming friend request' do
            visit user_path(user_1)

            within "#user-profile" do
                click_link 'Add Friend'
            end

            click_link 'Sign Out'
            sign_in(user_1)
            visit notifications_path

            within "#notification-#{user_1.notifications.first.id}" do
                expect(page).to have_content("#{user_2.name} sent you a friend request.")
                expect(page).to have_link 'Respond', href: friend_requests_path
            end
        end

        scenario 'for new post like' do
            Friendship.create(user: user_1, friend: user_2)
            visit post_path(user_1.posts.first)
            click_link 'Like Post'

            click_link 'Sign Out'
            sign_in(user_1)
            visit notifications_path

            within "#notification-#{user_1.notifications.first.id}" do
                expect(page).to have_content("#{user_2.name} liked your post.")
                expect(page).to have_link 'View', href: post_path(user_1.posts.first)
            end
        end

        scenario 'for new post comment' do
            Friendship.create(user: user_1, friend: user_2)
            visit post_path(user_1.posts.first)

            within "#post-#{user_1.posts.first.id}" do
                fill_in 'body', with: Faker::Quote.yoda
                click_button 'Comment'
            end

            click_link 'Sign Out'
            sign_in(user_1)
            visit notifications_path

            within "#notification-#{user_1.notifications.first.id}" do
                expect(page).to have_content("#{user_2.name} commented on your post.")
                expect(page).to have_link 'View', href: post_path(user_1.posts.first)
            end
        end

    end

end