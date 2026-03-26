class WishlistsController < ApplicationController
  def show
    @wishlist = current_user.wishlist
    @items = @wishlist.wishlist_items
  end
end