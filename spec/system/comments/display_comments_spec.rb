require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Comments', type: :system do

    feature 'Display Comments' do

        subject(:user) {FactoryBot.create(:user_with_post)}
        let(:user_2) {FactoryBot.create(:user)}

        let(:post) {user.posts.first}

        background(:each) do 
            sign_in(user)
            2.times do 
                FactoryBot.create(:comment, post: post, user: user_2)
            end
            FactoryBot.create(:comment, post: post, user: user)
        end

        scenario 'it displays all comments for post' do
            visit post_path(post)
            expect(page.find_all(:css, '.comment').size).to eq(post.comments.size)
        end

        scenario 'it displays comments from user' do
            visit post_path(post)
            expect(page).to have_content(Comment.where("user_id = ? AND post_id = ?", user.id, post.id).first.body)
        end

        scenario 'it displays comments from friends' do
            visit post_path(post)
            expect(page).to have_content(Comment.where("user_id = ? AND post_id = ?", user_2.id, post.id).first.body)
        end

        scenario 'displays comments in chronological order' do
            visit post_path(post)
            comments = page.find_all(:css, '.comment')
            comment_order = Comment.where("post_id = ?", post.id).order(:created_at)
            expect(comments[0].text).to have_content(comment_order[0].body)
            expect(comments[1].text).to have_content(comment_order[1].body)
            expect(comments[2].text).to have_content(comment_order[2].body)
        end

    end

end