ActiveAdmin.register Product do
  permit_params :name, :price, :user_id, :subcategory_id

  # Filters - remove cart_items or any invalid association
  filter :name
  filter :price
  filter :user
  filter :subcategory
  filter :created_at

  index do
    id_column
    column :name
    column :price
    column :user
    column :subcategory  
    column "Cart Count" do |product|
        product.cart_items.count
    end
    actions
  end
end