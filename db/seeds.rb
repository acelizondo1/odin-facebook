# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

10.times do |i|
    name = Faker::Name.name
    User.create({
        name: name,
        email: Faker::Internet.email(name:name),
        password: '123456'
    })
    3.times do
        post_body = Faker::Quote.most_interesting_man_in_the_world
        Post.create({
            user_id: i,
            body: post_body,
            updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
        })
    end
end

user = User.create({
    name: Faker::Name.name,
    email: 'test-email@odinfacebook.com',
    password: '123456'
})

5.times do |f|
    friend = User.find(f+1)
    Friendship.create(user: user, friend: friend)
end