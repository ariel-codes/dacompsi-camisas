require "commonmarker"

class Product < ApplicationRecord
  has_and_belongs_to_many :campaigns

  has_many_attached :images do |attachable|
    attachable.variant :thumbnail, resize_and_pad: [120, 120], format: :png, saver: {quality: 100}
    attachable.variant :opengraph, resize_and_pad: [120, 63], format: :png, saver: {quality: 100}
  end

  validate :validate_variations
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :name, :images, presence: true

  def price_in_reais
    price / 100.0
  end

  def description_html
    ::Commonmarker.to_html(description, options: {
      parse: {smart: true},
      extension: {description_lists: true, table: true}
    })
  end

  def thumbnail
    images.first.variant(:thumbnail)
  end

  def opengraph_thumbnail
    images.first.variant(:opengraph)
  end

  private

  def validate_variations
    return errors.add(:variations) unless variations.presence.is_a?(Hash)

    variations.each do |key, value|
      return errors.add(:variations) unless key.is_a?(String) && value.presence.is_a?(Array)
    end
  end
end
