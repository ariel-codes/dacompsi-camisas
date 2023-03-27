class Cart < ApplicationRecord
  visitable :ahoy_visit

  belongs_to :order, optional: true

  has_many :cart_products, dependent: :destroy
  has_many :products, through: :cart_products

  scope :open, -> { where(order: nil) }

  validates_associated :cart_products

  def total_price
    cart_products.map(&:total_price).sum
  end

  def total_price_in_reais
    total_price / 100.0
  end

  def empty?
    cart_products.empty?
  end
end
