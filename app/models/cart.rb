# frozen_string_literal: true

# Cart Model
class Cart < ApplicationRecord

  has_many :cart_item
end

