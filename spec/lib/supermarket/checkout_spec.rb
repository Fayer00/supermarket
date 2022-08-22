require 'rails_helper'

describe Supermarket::Checkout do
  context 'when invalid cart' do
      let(:checkout) {Supermarket::Checkout.new(cart_id: 9999) }
      let(:product) { create(:product) }

      it 'return error message' do
        expect(checkout.add(product)[:status]).to eq 'ERROR'
        expect(checkout.add(product)[:message]).to eq 'Cart not found'
      end
  end

  context 'valid cart' do
    let(:cart) { create(:cart) }
    let(:co) { Supermarket::Checkout.new(cart_id: cart.id) }
    let!(:coffee) { create(:product, name: 'Coffee', price: 11.23, product_code: 'CF1' )}
    let!(:tea) { create(:product, name: 'Green tea', price: 3.11, product_code: 'GR1' )}
    let!(:strawberries) { create(:product, name: 'Strawberries', price: 5.0, product_code: 'SR1' )}

    context 'add product to cart' do

      it 'add to cart' do
        co.add(coffee)
        cart_item = CartItem.last
        expect(Cart.last).to eq cart
        expect(cart_item.cart_id).to eq cart.id
        expect(cart_item.product.product_code).to eq coffee.product_code
        expect(cart_item.product.price).to eq coffee.price
      end

      it 'add multiple items to cart' do
        expect(cart.cart_item).to eq []
        first = co.add(tea)
        expect(first[:status]).to eq 'SUCCESS'
        expect(first[:result].product_id).to eq tea.id
        second = co.add(tea)
        expect(second[:status]).to eq 'SUCCESS'
        expect(second[:result]).to eq "Added #{tea.name} to your cart"
        third = co.add(tea)
        expect(third[:status]).to eq 'SUCCESS'
        expect(third[:result]).to eq "Added #{tea.name} to your cart"
        black = co.add(coffee)
        expect(black[:status]).to eq 'SUCCESS'
        expect(black[:result].product_id).to eq coffee.id
        straw = co.add(strawberries)
        expect(straw[:status]).to eq 'SUCCESS'
        expect(straw[:result].product_id).to eq strawberries.id
      end
    end

    context 'add items and get total' do
      it 'Total price expected: £22.45' do
        co.add(tea)
        co.add(tea)
        co.add(tea)
        co.add(coffee)
        co.add(strawberries)
        details = co.details
        price = co.total

        expect(price.total).to eq 25.560000000000002
        expect(price.total_discount).to eq 22.45
        expect(details.first[0]).to eq 'Green tea'
        expect(details.first[1]).to eq 3
        expect(details.second[0]).to eq 'Coffee'
        expect(details.second[1]).to eq 1
        expect(details.last[0]).to eq 'Strawberries'
        expect(details.last[1]).to eq 1
      end

      it 'Total price expected: £3.11' do
        co.add(tea)
        co.add(tea)
        details = co.details
        price = co.total

        expect(price.total).to eq 6.22
        expect(price.total_discount).to eq 3.11
        expect(details.first[0]).to eq 'Green tea'
        expect(details.first[1]).to eq 2
      end

      it 'Total price expected: £16.61' do
        co.add(tea)
        co.add(strawberries)
        co.add(strawberries)
        co.add(strawberries)
        details = co.details
        price = co.total

        expect(price.total).to eq 18.11
        expect(price.total_discount).to eq 16.61
        expect(details.first[0]).to eq 'Green tea'
        expect(details.first[1]).to eq 1
        expect(details.last[0]).to eq 'Strawberries'
        expect(details.last[1]).to eq 3
      end

      it 'Total price expected: £30.57' do
        co.add(tea)
        co.add(strawberries)
        co.add(coffee)
        co.add(coffee)
        co.add(coffee)
        details = co.details
        price = co.total

        expect(price.total).to eq 41.8
        expect(price.total_discount).to eq 30.57
        expect(details.first[0]).to eq 'Green tea'
        expect(details.first[1]).to eq 1
        expect(details.second[0]).to eq 'Strawberries'
        expect(details.second[1]).to eq 1
        expect(details.last[0]).to eq 'Coffee'
        expect(details.last[1]).to eq 3
      end
    end
  end
end

