require 'rails_helper'

RSpec.describe User, type: :model do
  subject (:user) {FactoryBot.build(:user)}

  describe "Validations" do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe "Associations" do
    context "Simple" do
      it {should have_many(:friend_requests)}
      it {should have_many(:pending_friends)}
      it {should have_many(:posts)}
      it {should have_many(:comments)}
      it {should have_many(:likes)}
      it {should have_many(:notifications)}
      it {should have_one_attached(:avatar)}
    end

    context "Complex" do 
      let (:user_1) {FactoryBot.create(:user)}
      let (:user_2) {FactoryBot.create(:user)}
      let (:user_3) {FactoryBot.create(:user)}
      let (:user_4) {FactoryBot.create(:user)}

      it "should build a two way friendship" do
        friendship = Friendship.create!(user: user_1, friend: user)
        expect(user.friendships[0].friend).to eq(user_1)
      end

      it "should connect with friends" do
        Friendship.create!(user: user, friend: user_1)
        Friendship.create!(user: user_2, friend: user)
        expect(user.friends).to eq([user_1, user_2])
      end

      describe "#non_friends" do
        it "should only return users who are not friends" do
          Friendship.create!(user: user, friend: user_1)
          Friendship.create!(user: user_2, friend: user)
          Friendship.create!(user: user, friend: user_1)
          
          expect(User.non_friends(user)).to eq([user_4]) 
        end
      end
    end
  end 
  
end