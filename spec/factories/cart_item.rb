# spec/cart_item.rb

FactoryBot.define do
  factory(:cart_item) do
    cart { create(:cart) }
    product { create(:product) }
  end
end
