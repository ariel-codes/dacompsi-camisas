class Order < ApplicationRecord
  visitable :ahoy_visit
  has_secure_token

  enum :payment_status,
    {pending: "pending", processing: "processing", completed: "completed", failed: "failed", cancelled: "cancelled"},
    prefix: :payment, default: :pending

  enum :order_status,
    {placed: "placed", cancelled: "cancelled"},
    prefix: :order, default: :placed

  belongs_to :buyer

  has_one :cart, dependent: :destroy, required: true
  delegate :cart_products, to: :cart

  validates_associated :buyer, :cart, on: :create
  validates :buyer, :cart, :cart_products, presence: true

  validates :total_price, numericality: {greater_than: 0, allow_nil: false}

  def total_price_in_reais
    total_price / 100.0
  end

  def order_cancelled!
    super
    payment_cancelled! unless payment_failed?
  end

  def payment_failed!
    super
    order_cancelled!
  end
end
