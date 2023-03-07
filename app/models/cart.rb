class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  scope :open, -> { where(closed: false) }

  def total_price
    cart_products.map(&:total_price).sum
  end

  def total_price_in_reais
    total_price / 100.0
  end

  def close!
    update!(closed: true)
  end
end
