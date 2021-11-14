require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) {FactoryBot.build(:post)}

  describe "Associations" do
    it{ should belong_to(:user) }
    it{ should have_many(:comments) }
    it{ should have_many(:likes) }
    it{ should have_one_attached(:photo) }
  end
end
