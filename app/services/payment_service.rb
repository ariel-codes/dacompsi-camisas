require "mercadopago"

class PaymentService
  include ActionView::Helpers::AssetUrlHelper

  DESCRIPTOR = "DACOMPSI"

  def initialize(order)
    @sdk = ::Mercadopago::SDK.new(ENV["MERCADOPAGO_SECRET_TOKEN"])
    @order = order
  end

  # Creates a payment preference for a given order
  # @param [string] order_url
  # @param [string] notify_order_url
  # @return [Array<string, string>] preference_id, init_point
  def create_payment(order_url, notify_order_url)
    preference_data = {
      statement_descriptor: DESCRIPTOR,
      items: order_items(@order.cart_products),
      payer: buyer_data(@order.buyer),
      binary_mode: true,
      auto_return: "approved",
      back_urls: {
        success: order_url,
        pending: order_url,
        failure: order_url
      },
      notification_url: notify_order_url
    }

    preference = @sdk.preference.create(preference_data)[:response]

    [preference["id"], preference["init_point"]]
  end

  def process_payment_notification(params)
    case params[:topic]
    when "merchant_order"
      merchant_order = @sdk.merchant_order.get(params[:id])[:response]
      update_order_status(merchant_order)
    when "chargebacks"
      # TODO: handle chargebacks
    end
  end

  private

  def update_order_status(merchant_order)
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
