# frozen_string_literal: true

# Product Model
class Product < ApplicationRecord

  validates :name, :price, :product_code, presence: true
  SR1_DISCOUNT_PRICE = 4.50
end
