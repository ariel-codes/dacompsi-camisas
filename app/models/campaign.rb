class Campaign < ApplicationRecord
  has_and_belongs_to_many :products

  scope :active, -> { where("start <= :today AND end >= :today", {today: Time.zone.today}) }

  validates :name, :start, :end, presence: true
end
