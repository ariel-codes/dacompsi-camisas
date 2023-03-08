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
      binary_mode: true,
      auto_return: "approved",
      back_urls: {
        success: back_url,
        failure: back_url
      },
      notification_url:
    }

    preference = @sdk.preference.create(preference_data)[:response]

    [preference["id"], preference["init_point"]]
  end

  def process_ipn(topic:, id:)
    case topic
    when "merchant_order"
      update_order_status(id)
    when "chargebacks"
      # TODO: handle chargebacks
    end
    debugger
  end

  def process_payment_redirect(merchant_order_id)
    update_order_status(merchant_order_id)
    debugger
  end

  private

  def update_order_status(merchant_order_id)
    merchant_order = @sdk.merchant_order.get(merchant_order_id)[:response]
    return unless merchant_order["external_reference"].to_i == @order.id

    if merchant_order["status"] == "closed"
      return @order.payment_completed!
    end

    if merchant_order["cancelled"]
      # TODO: handle cancelled orders
    end

    if merchant_order["expired"]
      return @order.payment_failed!
    end

    case merchant_order["order_status"]
    when "payment_required", "partially_paid"
      @order.payment_pending!
    when "payment_in_process"
      @order.payment_processing!
    when "reverted", "partially_reverted"
      @order.payment_failed!
    end
  end

  def order_items(cart_products)
    cart_products.map do |item|
      product = item.product
      {
        title: product.name,
        unit_price: product.price_in_reais,
        quantity: item.quantity,
        picture_url: asset_url("products/" + product.thumb_path),
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
