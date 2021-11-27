require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Likes', type: :system do

    feature 'Liked Posts Page' do
        let(:user_1) {FactoryBot.create(:user_with_post)}
        let(:user_2) {FactoryBot.create(:user_with_post)}

        background(:each) do
            sign_in(user_1)

            Friendship.create(user: user_1, friend: user_2)
            Like.create(user: user_1, post: user_1.posts.first)
            Like.create(user: user_1, post: user_2.posts.first)
        end

        scenario 'it displays all liked posts' do
            visit likes_path

            expect(page).to have_selector("#post-#{user_1.posts.first.id}")
            expect(page).to have_selector("#post-#{user_2.posts.first.id}")
        end

        scenario 'does not display unliked posts from friends' do
            visit likes_path

            expect(page).to_not have_selector("post-#{user_2.posts.last.id}")
        end
    end

end