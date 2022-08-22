require "rails_helper"

describe Cart, type: :model do

  describe "valid object" do
    subject {
      create(:cart)
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end
  end
end