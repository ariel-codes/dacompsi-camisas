class Product < ApplicationRecord
  VARIATIONS = []

  serialize :carousel_paths, JSON

  has_and_belongs_to_many :campaigns

  validate :validate_variations

  def price_in_reais
    price / 100.0
  end

  private

  def validate_variations
    return errors.add(:variations) unless variations.presence.is_a?(Hash)

    variations.each do |key, value|
      return errors.add(:variations) unless key.is_a?(String) && value.presence.is_a?(Array)
    end
  end
end
