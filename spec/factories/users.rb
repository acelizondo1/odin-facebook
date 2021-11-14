FactoryBot.define do 
    factory :user, aliases: [:friend] do 
        name { Faker::Name.name }
        email { Faker::Internet.email }
        password { Faker::Internet.password(min_length: 6) }
  end
end