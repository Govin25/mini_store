class Category < ApplicationRecord
    belongs_to :user
    has_many :subcategories
    has_many :products, through: :subcategories

    validates :name, presence: true
    
    
    def self.ransackable_attributes(auth_object = nil)
        ["id", "name", "created_at", "updated_at", "user_id"]
    end

    def self.ransackable_associations(auth_object = nil)
        ["user", "subcategories", "products"]
    end
end
