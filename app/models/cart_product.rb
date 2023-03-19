class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validate :validate_variations
  validates :quantity, :total_price, presence: true, numericality: {greater_than: 0}

  def total_price
    product.price * quantity
  end

  def total_price_in_reais
    total_price / 100.0
  end

  def change_quantity(change)
    new_quantity = change + quantity
    if new_quantity > 0
      update!(quantity: new_quantity)
    else
      destroy!
    end
  end

  private

  def validate_variations
    return errors.add(:variations) unless variations.presence.is_a?(Hash)

    variations.each do |key, value|
      unless value.in?(product.variations[key])
        return errors.add(:variations)
      end
    end
  end
end
