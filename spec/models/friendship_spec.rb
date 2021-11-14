require 'rails_helper'

RSpec.describe Friendship, type: :model do
  subject(:friendship) {FactoryBot.build(:friendship)}

  let (:user_1) {FactoryBot.create(:user)}
  let (:user_2) {FactoryBot.create(:user)}
  let (:user_3) {FactoryBot.create(:user)}
  let (:user_4) {FactoryBot.create(:user)}

  describe "Validations" do
    let (:user) {FactoryBot.create(:user)}
    it "cannot friend the same person" do 
      friendship = Friendship.new(user: user, friend: user)
      expect(friendship).to_not be_valid
    end
  end

  describe "Associations" do 
    it{ should belong_to(:user) }
    it{ should belong_to(:friend).class_name(:User) }
  end

  describe "Inverse Operations" do
    describe "#create_inverse_relationship" do
      it "creates a 2 way friendship" do
        friendship = Friendship.create!(user: user_1, friend: user_2)
        expect(user_2.friendships.first.friend).to eq(user_1)
      end
    end

    describe "#destroy_inverse_relationship" do
      it "deletes the other half of friendship when the first is destroyed" do
        friendship_1 = Friendship.create!(user: user_3, friend: user_4)
        friendship_1.destroy!
        expect(user_4.friends.first).to_not eq(user_3)
      end
    end
  end

  describe "Scopes" do
    describe "#locate_friendship" do
      it "returns the correct friendship" do
        friendship_2 = Friendship.create!(user: user_1, friend: user_4)
        expect(Friendship.locate_friendship(user_1, user_4).first).to eq(friendship_2)
      end
    end
  end
end