# frozen_string_literal: true

# CartItems Model
class CartItem < ApplicationRecord

  belongs_to :products
  belongs_to :cart
  belongs_to :order
  #ID lista_prod total, total_discount


end

