class Cart < ApplicationRecord
  has_many :cart_products
  has_many :products, through: :cart_products

  validate :validate_variations

  private

  def validate_variations
    return errors.add(:variations) unless variations.presence.is_a?(Hash)

    variations.each do |key, value|
      unless key.in?(self.class::VARIATIONS) && value.presence.is_a?(String)
        return errors.add(:variations)
      end
    end
  end
end
