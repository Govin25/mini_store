class CartItemsController < ApplicationController

  def create


    user = User.find(params[:user_id])

    product = Product.find(params[:product_id])

    cart = user.cart


    cart_item = CartItem.find_by(cart_id: cart.id, product_id: product.id)

    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      CartItem.create(
        cart_id: cart.id,
        product_id: product.id,
        quantity: 1
      )
    end

    redirect_to products_path

  end

end