ActiveAdmin.register Category do
  permit_params :name, :user_id

  index do
    id_column
    column :name
    column :user
    actions
  end
end