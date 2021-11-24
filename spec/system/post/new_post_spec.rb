require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Posts', type: :system do

    feature 'New Post' do
        subject(:user) {FactoryBot.create(:user)}

        background(:each) do 
            sign_in(user)
            visit new_post_path
        end

        scenario 'submits post with valid body' do
            post_body = Faker::Quote.matz
            within '#post-form' do
                fill_in 'post_body', with:  post_body
                click_button 'Post'
            end
            expect(page).to have_content('Status Posted!')
            expect(user.posts.first.body).to eq(post_body)
        end

        scenario 'submits post with image attached' do
            within '#post-form' do 
                find('input', {id: 'post_photo', visible: false}).set(Rails.root + 'spec/support/assets/post_photo.jpg')
                fill_in 'post_body', with: Faker::Quote.matz
                click_button 'Post'
            end
            expect(page).to have_content('Status Posted!')
            expect(user.posts.first.photo.attached?).to be true
            expect(user.posts.size).to eq(1)
        end

        scenario 'will not submit post with empty body' do
            within '#post-form' do
                click_button 'Post'
            end
            expect(page).to have_content('There was an issue posting. Please try again.')
            expect(user.posts.size).to eq(0)
        end

        scenario 'will not submit attachment that is not an image' do
            within '#post-form' do
                find('input', {id: 'post_photo', visible: false}).set(Rails.root + 'spec/support/assets/test.txt')
                click_button 'Post'
            end
            expect(page).to have_content('There was an issue posting. Please try again.')
            expect(user.posts.size).to eq(0)
        end

    end

end