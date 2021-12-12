# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

users = []
15.times do |i|
    name = Faker::Name.name
    response = Net::HTTP.get_response(URI.parse(Faker::Avatar.image))
    response = Net::HTTP.get_response(URI.parse(response['location'])) if response.code == "302"
    file = StringIO.new(response.body)
    user = User.create!({
        name: name,
        email: Faker::Internet.email(name:name),
        password: '123456'
    })
    user.avatar.attach(io: file, filename: "user_avatar_#{user.id}.jpg", content_type: "image/jpg")
    
    3.times do
        post_body = Faker::Quote.most_interesting_man_in_the_world
        Post.create!({
            user_id: user.id,
            body: post_body,
            updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
        })
    end
    users << user
end

user = User.create!({
    name: Faker::Name.name,
    email: 'test-email@odinfacebook.com',
    password: '123456'
})
friends = users.first(5)
friends.each do |friend|
    Friendship.create!(user: user, friend: friend)
end