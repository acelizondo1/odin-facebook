FactoryBot.define do 
    factory :post do 
        user
        body {Faker::Quote.matz}

        factory :post_with_photo do
          photo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'post_photo.jpg'), 'img/jpg') }
        end
  end
end