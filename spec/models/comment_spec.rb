require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) {FactoryBot.build(:comment)}

  describe "Associations" do 
    it { should belong_to(:user) }
    it { should belong_to(:post) }
    it { should have_one(:notification) }
  end

  describe "Validations" do 
    it { should validate_presence_of(:body) }
  end
end
