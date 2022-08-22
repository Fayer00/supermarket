require "rails_helper"

describe Product, type: :model do

  describe "valid object" do
    subject {
      create(:product)
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a value" do
      subject.price = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a timestamp" do
      subject.product_code = nil
      expect(subject).to_not be_valid
    end
  end
end