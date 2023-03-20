require "mercadopago"

class PaymentService
  include ActionView::Helpers::AssetUrlHelper

  DESCRIPTOR = "DACOMPSI"

  def initialize(order)
    @sdk = ::Mercadopago::SDK.new(ENV["MERCADOPAGO_SECRET_TOKEN"])
    @order = order
  end

  # Creates a payment preference for a given order
  # @param [string] notification_url
  # @param [string] back_url
  # @return [Array<string, string>] preference_id, init_point
  def create_payment(notification_url:, back_url:)
    preference_data = {
      statement_descriptor: DESCRIPTOR,
      external_reference: @order.id,
      items: order_items(@order.cart_products),
      payer: buyer_data(@order.buyer),
      date_of_expiration: Date.tomorrow.end_of_day,
      auto_return: "approved",
      back_urls: {
        success: back_url,
        failure: back_url
      },
      notification_url:
    }

    preference = @sdk.preference.create(preference_data)[:response]

    @order.update!(payment_preference_id: preference["id"])

    notify_buyer(@order.order_status)

    preference["init_point"]
  end

  def process_ipn(topic:, id:)
    case topic
    when "merchant_order"
      update_order_status(id)
    when "chargebacks"
      # TODO: handle chargebacks
    end
  end

  def process_payment_redirect(merchant_order_id)
    update_order_status(merchant_order_id)
  end

  private

  # TODO: extract to a module/class
  def notify_buyer(status)
    mailer = OrderMailer.with(order: @order)

    message = case status
    when "completed"
      :paid
    when "failed"
      :failed
    when "placed"
      :confirmation
    when "cancelled"
      :cancelled
    end

    notification = BuyerNotification.create(buyer: @order.buyer, notification: message)
    if message && notification.save
      mailer.public_send(message).deliver_later
    end
  end

  # https://www.mercadopago.com.br/developers/pt/reference/merchant_orders/_merchant_orders_id/get

  def update_order_status(merchant_order_id)
    merchant_order = @sdk.merchant_order.get(merchant_order_id)[:response]
    return unless merchant_order["external_reference"].to_i == @order.id

    Rails.logger.info "Updating order status for order #{@order.id} to #{merchant_order["status"] || merchant_order["order_status"]}"

    if merchant_order["order_status"] == "paid"
      @order.payment_completed!
    elsif merchant_order["order_status"] == "payment_in_process"
      @order.payment_processing!
    elsif merchant_order["cancelled"] || merchant_order["order_status"] == "reverted"
      @order.order_cancelled!
    elsif merchant_order["status"] == "expired" || merchant_order["order_status"] == "expired"
      @order.payment_failed!
    end

    notify_buyer(@order.payment_status)
  end

  def order_items(cart_products)
    cart_products.map do |item|
      product = item.product
      {
        title: product.name,
        unit_price: product.price_in_reais,
        quantity: item.quantity,
        picture_url: Rails.application.routes.url_helpers.rails_blob_url(product.thumbnail),
        currency_id: "BRL"
      }
    end
  end

  def buyer_data(buyer)
    area_code, phone_number = buyer.telephone.split(" ")

    {
      name: buyer.name,
      email: buyer.email,
      phone: {
        area_code: area_code,
        number: phone_number
      }
    }
  end
end
