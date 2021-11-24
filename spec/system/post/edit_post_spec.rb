require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Posts', type: :system do

    feature 'Edit Post' do

        given!(:user) {FactoryBot.create(:user_with_post_with_photo)}
        let(:user_1) {FactoryBot.create(:user_with_post_with_photo)}

        background(:each) do 
            sign_in(user)
        end

        scenario 'updates post body' do
            visit edit_post_path(user.posts.first)
            within '#post-form' do
                fill_in 'post_body', with: 'New Post Body'
                click_button 'Update'
            end
            expect(user.posts.first.body).to eq('New Post Body')
        end

        scenario 'updates post photo' do
            visit edit_post_path(user.posts.first)
            within '#post-form' do
                find('input', {id: 'post_photo', visible: false}).set(Rails.root + 'spec/support/assets/test_image_2.png')
                click_button 'Update'
            end
            expect(user.posts.first.photo.filename).to eq('test_image_2.png')
        end

        scenario 'will not update post with empty body' do
            visit edit_post_path(user.posts.first)
            within '#post-form' do
                fill_in 'post_body', with: ''
                click_button 'Update'
            end
            expect(page).to have_content('Your post could not be updated at this time. Please try again.')
        end

        scenario 'will not allow user to edit posts they did not author' do
            visit edit_post_path(user_1.posts.first)
            expect(page).to have_content("You cannot edit this post!")
            expect(page).to have_current_path(post_path(user_1.posts.first))
        end

        scenario 'will successfully delete post' do
            visit post_path(user.posts.first)
            
            click_link 'Delete Post'
            expect(page).to have_content('Your post was deleted.')
            expect(user.posts.size).to eq(0)
        end

    end

end