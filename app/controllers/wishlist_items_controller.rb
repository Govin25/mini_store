class WishlistItemsController < ApplicationController

  before_action :check_customer

  def create
    product = Product.find(params[:product_id])
    wishlist = current_user.wishlist || Wishlist.create(user: current_user)

    wishlist.wishlist_items.find_or_create_by(product: product)

    redirect_to products_path, notice: "Added to Wishlist ❤️"
  end

  def destroy
    item = WishlistItem.find(params[:id])
    item.destroy

    redirect_to wishlist_path, notice: "Removed from Wishlist ❌"
  end

  private

  def check_customer
    unless current_user.role == "customer"
      redirect_to products_path, alert: "Only customers allowed!"
    end
  end

end