class Campaign < ApplicationRecord
  has_and_belongs_to_many :products

  scope :active, -> { where("start <= :now AND end >= :now", {now: Time.zone.now}) }

  validates :name, :start, :end, presence: true
end
