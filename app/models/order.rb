class Order < ApplicationRecord
  has_secure_token

  belongs_to :buyer

  has_one :cart
  delegate :cart_products, to: :cart

  validates_associated :buyer, :cart
  validates :buyer, :cart, :total_price, presence: true

  def total_price_in_reais
    total_price / 100.0
  end
end
