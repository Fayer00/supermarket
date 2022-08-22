module Supermarket
  class Checkout
    def add(item)

      #this could be validated on the controller but i don't have a controller
      return { status: 'ERROR', message: 'Cart not found' } if cart.nil?

      result = add_to_cart(item)
      { status: 'SUCCESS', result: result }.compact
    end

    def total
      get_totals(cart)
    end

    def details
      print_details
    end

    private

    attr_reader :cart

    # asdf = Supermarket::Checkout.new(cart_id: c.id)
    # @param [Object] cart
    def initialize(cart_id:)
      @cart = Cart.find_by(id: cart_id)
    end

    def add_to_cart(item)
      product = Product.find_by(product_code: item[:product_code])
      find_or_create_card_item(product)
    end

    def print_details
      cart.cart_item.map { |ct| [ct.product.name, ct.quantity]}
    end

    def find_or_create_card_item(product)
      cart_item = cart.cart_item.find_by(product_id: product.id)
      if cart_item.present?
        quantity = cart_item.quantity
        cart_item.update(quantity: quantity + 1)
        return "Added #{product.name} to your cart"
      end
      CartItem.create(product: product, quantity: 1, cart: cart)
    end

    def get_totals(cart)
      total = 0
      total_discount = 0
      cart.cart_item.each do |item|
        total += item.product.price * item.quantity
        total_discount += calculate_discount(item.product.product_code, item.quantity, item.product)
      end
      cart.update(total: total, total_discount: total_discount)
      cart
    end

    def calculate_discount(code, quantity, product)
      #a better approach here would be to creat a discount_rules mode with reference to a product, discount rules and discoun criteria
      total = 0
      case code
      when 'SR1'
        #The COO, though, likes low prices and wants people buying strawberries to get a price
        # discount for bulk purchases. If you buy 3 or more strawberries, the price should drop to £4.50
        total = if quantity >= 3
                  Product::SR1_DISCOUNT_PRICE * quantity
                else
                  product.price * quantity
                end
      when 'GR1'
        #The CEO is a big fan of buy-one-get-one-free offers and of green tea. He wants us to add a
        # rule to do this.
        discount = if quantity.even?
                     product.price * (quantity * 0.5).to_i
                   else
                     product.price * (((quantity - 1) * 0.5).to_i + 1)
                   end

        total = discount
      when 'CF1'
        #The CTO is a coffee addict. If you buy 3 or more coffees, the price of all coffees should drop
        # to two thirds of the original price
        total = if quantity >= 3
                  ((product.price / 3) * 2) * quantity
                else
                  product.price * quantity
                end
      end
       total
    end
  end
end