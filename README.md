# README

* Clone repo
* You can run the seeds bundle exec rake db:seed  or create the product manually 
 ```
products = [
  {product_code: 'GR1', name: 'Green tea', price: 3.11},
  {product_code: 'SR1', name: 'Strawberries', price: 5.00},
  {product_code: 'CF1', name: 'Coffee', price: 11.23}
]

Product.create(products)
```
# To execute 

* First create a new cart 
```
cart = Cart.create

```
* Then create a new Checkout
```
co = Supermarket::Checkout.new(cart_id: cart.id)
```
* Add items to the cart
```
co.add(product)
```
you have to use a product Object

* Add more products to the cart

* Calculate total price and total with discounts
```
co.total
```
This will return a Cart Object with the total price and total with discount

* You can get a list of items in the cart with 
```
co.details
```