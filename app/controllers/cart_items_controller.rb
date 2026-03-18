class CartItemsController < ApplicationController

  before_action :check_customer

  def create
    product = Product.find(params[:product_id])
    cart = current_user.cart

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

    redirect_to products_path, notice: "Added to cart"
  end

  private

  def check_customer
    unless current_user.role == "customer"
      redirect_to products_path, alert: "Only customers allowed!"
    end
  end

end