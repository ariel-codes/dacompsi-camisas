class Order < ApplicationRecord
  belongs_to :buyer
  belongs_to :cart
  
  has_many :cart_products, through: :cart

  validates :buyer, :cart, :total_price, presence: true

  def total_price_in_reais
    total_price / 100.0
  end
end
