require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(email: 'test@test.com', password: '123456')
    expect(user).to be_valid
  end

  it "is not valid without an email" do 
    user = User.new(email: nil, password: '123456')
    expect(user).to_not be_valid
  end

  it "is not valid without a password" do 
    user = User.new(email: 'test@test.com', password: nil)
    expect(user).to_not be_valid
  end

  
end