class Product < ApplicationRecord
    validates :name, presence:true
    validates :price, presence: true, numericality: { greater_than: 0 }
    belongs_to :user
    belongs_to :subcategory
    has_many :cart_items
    has_many :wishlist_items
    
    def self.ransackable_attributes(auth_object = nil)
        ["id", "name", "price", "user_id", "subcategory_id", "created_at", "updated_at"]
    end
    
    def self.ransackable_associations(auth_object = nil)
        ["user", "subcategory"]
    end

end
