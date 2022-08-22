# spec/product.rb

FactoryBot.define do
  factory(:product) do
    name { Faker::Name.unique.name }
    price { Faker::Commerce.price }
    product_code { 'GR1' }
  end
end
