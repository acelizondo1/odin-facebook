require 'rails_helper'
require 'helpers'
require 'database_cleaner/active_record'


RSpec.configure do |c|
    c.include Helpers
    c.before do
        DatabaseCleaner.strategy = :truncation
        DatabaseCleaner.clean
    end
end

RSpec.describe 'Users', type: :system do

    feature 'Suggest Friends' do

        subject(:user) {FactoryBot.create(:user, :with_avatar)}
        
        given!(:user_2) {FactoryBot.create(:user)}
        given!(:user_3) {FactoryBot.create(:user)}
        given!(:user_4) {FactoryBot.create(:user)}

        background(:each) do 
            sign_in(user)
            visit root_path
        end

        scenario 'displays users in side panel' do
            within '#suggest-friends' do
                expect(page).to have_content(user_2.name)
            end
        end

        scenario 'does not display logged in user' do
            within '#suggest-friends' do
                expect(page).to_not have_content(user.name)
            end
        end

        scenario 'does not display users who are already friends' do 
            Friendship.create!(user: user, friend: user_2)
            page.evaluate_script 'window.location.reload()'
            within '#suggest-friends' do   
                expect(page).to_not have_content(user_2.name)
            end
        end       

        scenario 'displays only 5 users' do
            3.times do 
                FactoryBot.create(:user)
            end
            page.evaluate_script 'window.location.reload()'
            within '#suggest-friends' do
                expect(find_all(:css, '.suggested-user').size).to eq(5)
            end
        end

    end

end