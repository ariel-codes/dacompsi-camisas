class BuyerNotification < ApplicationRecord
  belongs_to :buyer

  validates_uniqueness_of :notification, scope: :buyer_id
end
