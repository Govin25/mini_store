class AddSubcategoryToProducts < ActiveRecord::Migration[8.0]
  def change
    add_reference :products, :subcategory, foreign_key: true
  end
end
