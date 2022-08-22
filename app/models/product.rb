# frozen_string_literal: true

# Products Model
class Product < ApplicationRecord

  #ID Product_code, Name, Price
  belongs_to :cart
  validates :name, :price, :product_code, presence: true
end
