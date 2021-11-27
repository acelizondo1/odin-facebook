require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Posts', type: :system do

    feature 'New Comment' do

        subject(:user) {FactoryBot.create(:user_with_post)}
        let(:user_2) {FactoryBot.create(:user_with_post)}

        background(:each) do 
            sign_in(user)
        end

        scenario 'able to new comment on own post' do
            visit post_path(user.posts.first)
            within "#post-#{user.posts.first.id}" do
                fill_in 'body', with: Faker::Quote.yoda
                click_button 'Comment'
            end
            expect(user.posts.first.comments.size).to eq(1)
            expect(page).to have_content('Comment Posted!')
        end

        scenario 'able to comment on a friends post' do
            Friendship.create(user: user, friend: user_2)
            visit post_path(user_2.posts.first)
            within "#post-#{user_2.posts.first.id}" do
                fill_in 'body', with: Faker::Quote.yoda
                click_button 'Comment'
            end
            expect(user_2.posts.first.comments.size).to eq(1)
            expect(page).to have_content('Comment Posted!')
        end

        scenario 'unable to comment on an unfriended users post' do
            visit post_path(user_2.posts.first)
            within "#post-#{user_2.posts.first.id}" do
                expect(page).to_not have_content('Comment')
            end
        end

        scenario 'unable to comment with empy body' do
            visit post_path(user.posts.first)
            within "#post-#{user.posts.first.id}" do
                fill_in 'body', with: ''
                click_button 'Comment'
            end
            expect(page).to have_content('There was an issue posting your comment. Please try again.')
            expect(user.posts.first.comments.size).to eq(0)
        end

    end

end