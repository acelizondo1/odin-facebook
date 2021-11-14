require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  subject(:friend_request) {FactoryBot.build(:friend_request)}

  let (:user_1) {FactoryBot.create(:user)}
  let (:user_2) {FactoryBot.create(:user)}

  describe "Validations" do 
    it "should not allow a user to request themself" do
      expect{FriendRequest.create!(user: user_1, friend: user_1)}.to raise_error("Validation failed: Friend can't be equal to user")
    end

    it "should not allow a request if a users are already friends" do
      Friendship.create!(user: user_1, friend: user_2)
      expect{FriendRequest.create!(user: user_1, friend: user_2)}.to raise_error("Validation failed: Friend is already added")
    end

    it "should not allow a new request if user already has one sent" do 
      FriendRequest.create!(user: user_1, friend: user_2)
      expect{FriendRequest.create!(user: user_2, friend: user_1)}.to raise_error("Validation failed: Friend already requested friendship")
    end
  end

  describe "Scopes" do
    describe "#locate_friendship" do
      it "returns the correct friend_request" do
        friend_request1 = FriendRequest.create!(user: user_1, friend: user_2)
        expect(FriendRequest.locate_request(user_1, user_2).first).to eq(friend_request1)
      end
    end
  end
end