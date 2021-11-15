FactoryBot.define do
    factory :notification do
        user
        
        for_post

        trait :for_post do
            association :notifiable, factory: :post
        end
        
        trait :for_comment do
            association :notifiable, factory: :comment
        end

        trait :for_like do
            association :notifiable, factory: :like
        end

        trait :for_friend_request do
            association :notifiable, factory: :friend_request
        end
    end
end