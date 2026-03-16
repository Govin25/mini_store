class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         

  enum :role, { customer: 0, supplier: 1 }


    has_one :cart
    has_many :products

   

    after_create :create_user_cart


    private

    def create_user_cart
        Cart.create(user_id: self.id)

    end
end
