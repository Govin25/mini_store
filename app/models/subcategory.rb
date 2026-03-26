class Subcategory < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :products


  validates :name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "category_id", "user_id", "created_at", "updated_at"]
  end

  
  def self.ransackable_associations(auth_object = nil)
    ["category", "user", "products"]
  end
end
