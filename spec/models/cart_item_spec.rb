require "rails_helper"

describe CartItem, type: :model do

  describe "valid object" do
    subject {
      create(:cart_item)
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a cart" do
      subject.cart = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a product" do
      subject.product = nil
      expect(subject).to_not be_valid
    end
  end
end