class CartsController < ApplicationController

  before_action :check_customer

  def show
    @cart = current_user.cart
    @cart_items = @cart.cart_items
  end

  private

  def check_customer
    unless current_user.role == "customer"
      redirect_to products_path, alert: "Only customers can access cart"
    end
  end

end