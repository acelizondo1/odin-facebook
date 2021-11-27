require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Posts', type: :system do

    feature 'Main Feed' do
        given!(:user) {FactoryBot.create(:user_with_post)}
        given!(:user_2) {FactoryBot.create(:user_with_post)}
        given!(:user_3) {FactoryBot.create(:user_with_post)}
        given!(:user_4) {FactoryBot.create(:user_with_post)}

        background(:each) do 
            Friendship.create!(user: user, friend: user_2)
            sign_in(user)
            visit posts_path
        end

        scenario 'shows user posts' do
            expect(page).to have_content(user.posts.first.body)
        end

        scenario 'shows user\'s friends posts' do
            expect(page).to have_content(user_2.posts.first.body)
        end

        scenario 'does not show posts from users who are not friended' do
            expect(page).to_not have_content(user_3.posts.first.body)
        end

        scenario 'does not show posts from pending friends' do
            FriendRequest.create!(user: user, friend: user_4)
            expect(page).to_not have_content(user_4.posts.first.body)
        end

        scenario 'allows user to open post edit for their posts' do
            post_id = "#post-" + user.posts.first.id.to_s
            within post_id do
                expect(page).to have_link('Edit Post')
                expect(page).to have_link('Delete Post')
            end
        end

        scenario 'does not allow user to open post edit on posts they did not author' do
            post_id = "#post-" + user_2.posts.first.id.to_s
            within post_id do
                expect(page).to_not have_link('Edit Post')
                expect(page).to_not have_link('Delete Post')
            end
        end
    end

end