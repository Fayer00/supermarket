# frozen_string_literal: true

# CartItem Model
class CartItem < ApplicationRecord

  belongs_to :product
  belongs_to :cart

end

