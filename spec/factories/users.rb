include ActionDispatch::TestProcess::FixtureFile
FactoryBot.define do 
    factory :user, aliases: [:friend] do 
        name { Faker::Name.name }
        email { Faker::Internet.email }
        password { Faker::Internet.password(min_length: 6) }

        trait :with_avatar do
          avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test_image.png'), 'img/png') }
        end

        factory :user_with_post do
          after :create do |user|
            create :post, user: user
          end
        end

        factory :user_with_post_with_photo do
          after :create do |user|
            create :post_with_photo, user: user
          end
        end
  end
end