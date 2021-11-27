require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Comments', type: :system do

    feature 'Edit Comment' do

        subject(:user_1) {FactoryBot.create(:user_with_post)}
        let!(:user_2) {FactoryBot.create(:user)}

        let!(:post) {user_1.posts.first}

        let!(:user_1_comment) {FactoryBot.create(:comment, post: post, user: user_1)}
        let!(:user_2_comment) {FactoryBot.create(:comment, post: post, user: user_2)}

        background(:each) do  
            sign_in(user_1)
        end

        scenario 'it only shows delete link for post author' do
            visit post_path(post)
            within "#comment-#{user_1_comment.id}" do
                expect(page).to have_link('Delete Comment')
            end
        end

        scenario 'it does not show delete link for any other user' do
            visit post_path(post)
            within "#comment-#{user_2_comment.id}" do
                expect(page).to_not have_link('Delete Comment')
            end
        end

        scenario 'it deletes comment' do
            puts post.id
            puts user_1_comment.id
            visit post_path(post)
            within "#comment-#{user_1_comment.id}" do
                click_link 'Delete Comment'
            end
            expect(page).to have_content("Your comment was deleted.")
        end

    end

end