class Product < ApplicationRecord
    validates :name, presence:true
    validates :price, presence: true, numericality: { greater_than: 0 }
    belongs_to :user
    belongs_to :subcategory
    has_many :cart_items

end
