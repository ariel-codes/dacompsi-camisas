require "commonmarker"

class Product < ApplicationRecord
  has_and_belongs_to_many :campaigns

  has_one_attached :thumbnail
  has_many_attached :images

  validate :validate_variations
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}

  def price_in_reais
    price / 100.0
  end

  def description_html
    ::Commonmarker.to_html(description, options: {
      parse: {smart: true},
      extension: {description_lists: true, table: true}
    })
  end

  private

  def validate_variations
    return errors.add(:variations) unless variations.presence.is_a?(Hash)

    variations.each do |key, value|
      return errors.add(:variations) unless key.is_a?(String) && value.presence.is_a?(Array)
    end
  end
end
