require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Notifications', type: :system do

    feature 'Creates Notifications' do
        let(:user_1) {FactoryBot.create(:user)}
        let(:user_2) {FactoryBot.create(:user_with_post)}

        background(:each) do
            sign_in(user_1)
        end

        scenario 'when a new friend request is received' do
            visit user_path(user_2)

            within "#user-profile" do
                click_link 'Add Friend'
            end

            expect(user_2.notifications.count).to eq(1)
            expect(page).to have_content('Delete Request')
        end

        scenario 'when a user post receives a new like' do
            Friendship.create(user: user_1, friend: user_2)
            visit post_path(user_2.posts.first)

            within ".likes" do
                click_link "Like Post"
            end

            expect(user_2.notifications.count).to eq(1)
            expect(page).to have_selector(".fas.fa-thumbs-up")
           
        end

        scenario 'when a user post receives a new comment' do
            Friendship.create(user: user_1, friend: user_2)
            post = user_2.posts.first
            visit post_path(post)

            within "#post-#{post.id}" do
                fill_in 'body', with: Faker::Quote.yoda
                click_button 'Comment'
            end
            
            expect(user_2.notifications.count).to eq(1)
            expect(page).to have_selector("#comment-#{post.comments.first.id}")
        end
    end

end