FactoryBot.define do 
    factory :post do 
        user
        body {Faker::Quote.matz}
  end
end