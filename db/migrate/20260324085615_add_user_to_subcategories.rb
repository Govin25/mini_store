class AddUserToSubcategories < ActiveRecord::Migration[8.0]
  def change
    add_reference :subcategories, :user, foreign_key: true
  end
end
