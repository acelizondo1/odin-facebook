require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject(:notification) {FactoryBot.build(:notification)}

  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:notifiable) }
  end
end
