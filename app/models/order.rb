class Order < ApplicationRecord
  has_secure_token

  enum :payment_status,
    {pending: "pending", processing: "processing", completed: "completed", failed: "failed"},
    prefix: :payment, default: :pending

  belongs_to :buyer

  has_one :cart, dependent: :destroy, required: true
  delegate :cart_products, to: :cart

  validates_associated :buyer, :cart, on: :create
  validates :buyer, :cart, :total_price, presence: true

  def total_price_in_reais
    total_price / 100.0
  end
end
