ActiveAdmin.register Subcategory do
  permit_params :name, :category_id, :user_id

  index do
    id_column
    column :name
    column :category
    column :user
    actions
  end
end