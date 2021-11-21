include ActionDispatch::TestProcess::FixtureFile
FactoryBot.define do 
    factory :user, aliases: [:friend] do 
        name { Faker::Name.name }
        email { Faker::Internet.email }
        password { Faker::Internet.password(min_length: 6) }

        trait :with_avatar do
          avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test_image.png'), 'img/png') }
        end
  end
end