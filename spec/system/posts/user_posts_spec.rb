require 'rails_helper'
require 'helpers'

RSpec.configure do |c|
    c.include Helpers
end

RSpec.describe 'Posts', type: :system do

    feature 'User Post Page' do
        subject(:user) {FactoryBot.create(:user_with_post)}
        subject(:user_2) {FactoryBot.create(:user_with_post)}
        let(:post) {FactoryBot.create(:post, user: user)}

        background(:each) do 
            sign_in(user)
            visit user_posts_path
        end

        scenario 'only displays logged in user posts' do
            expect(page).to have_content(user.posts.first.body)
            expect(page).to have_content(user.posts.last.body)
            expect(page).to_not have_content(user_2.posts.first.body)
        end

    end

end