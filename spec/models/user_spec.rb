require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) {FactoryBot.build(:user)}

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
          
          expect(User.non_friends(user)).to_not include([user_1, user_2, user_3]) 
        end
      end

      describe "#is_friend?" do
        it "should return true if passed user is a current friend" do
          Friendship.create!(user: user, friend: user_1)
          expect(User.is_friend?(user, user_1)).to be true
        end

        it "should return false if passed user is not a friend" do
          expect(User.is_friend?(user, user_4)).to be false
        end
      end
    end
  end 
  
end