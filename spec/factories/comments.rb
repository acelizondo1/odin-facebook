FactoryBot.define do 
    factory :comment do 
        user
        post
        body { Faker::Lorem.sentence(word_count: 10) }
    end
end