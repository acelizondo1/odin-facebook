require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Likes', type: :system do

    feature 'Like User Post' do
        let(:user_1) {FactoryBot.create(:user_with_post)}
        let(:user_2) {FactoryBot.create(:user)}
        let(:user_3) {FactoryBot.create(:user)}

        let(:post) {user_1.posts.first}

        before(:each) do
            Friendship.create(user: user_1, friend: user_2)
        end

        scenario 'it allows user to like own post' do
            sign_in(user_1)
            visit post_path(post)

            within "#post-#{post.id}" do
                click_link 'Like Post'
            end
            expect(post.likes.count).to eq(1)
            expect(page).to have_selector('.fas.fa-thumbs-up')
        end

        scenario 'it allows friends to like post' do
            sign_in(user_2)
            visit post_path(post)

            within "#post-#{post.id}" do
                click_link 'Like Post'
            end
            expect(post.likes.count).to eq(1)
            expect(page).to have_selector('.fas.fa-thumbs-up')
        end

        scenario 'it allows friend to unlike post' do
            sign_in(user_2)
            visit post_path(post)

            within "#post-#{post.id}" do
                click_link 'Like Post'
                click_link 'Like Post'
            end
            expect(post.likes.count).to eq(0)
            expect(page).to have_selector('.far.fa-thumbs-up')
        end

        scenario 'it does not allow unfriended users to like post' do
            sign_in(user_3)
            visit post_path(post)
            
            within "#post-#{post.id}" do
                expect(page).to_not have_selector('.far.fa-thumbs-up')
            end
        end
    end

end