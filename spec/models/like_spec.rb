require 'rails_helper'

RSpec.describe Like, type: :model do
  subject(:like) {FactoryBot.build(:like)}

  describe "Associations" do
    it { should belong_to :user }
    it { should belong_to :post }
    it { should have_many :notifications }
  end

  describe "Scopes" do
    describe "#locate_like" do
      it "should return the correct like record based off given post and user id" do
        user = FactoryBot.create(:user)
        post = user.posts.create!(body: "Test")
        like = Like.create!(user: user, post: post)
        expect(Like.locate_like(user, post).first).to eql(like)
      end
    end
  end
end
