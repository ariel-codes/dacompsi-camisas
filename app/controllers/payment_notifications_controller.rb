class PaymentNotificationsController < ApplicationController
  include TokenSession

  skip_before_action :verify_authenticity_token
  before_action :retrieve_session_from_token, only: [:after_redirect]

  def ipn
    ipn_params => {topic:, id:}
    order = Order.find_by!(id: params[:order_id], token: params[:token])
    PaymentService.new(order).process_ipn(topic:, id:)

    head :ok
  end

  def after_redirect
    merchant_order_params => {merchant_order_id:, external_reference:}

    if external_reference.to_i == @order.id
      PaymentService.new(@order).process_payment_redirect(merchant_order_id)
    end

    redirect_to order_path(@order)
  end

  private

  def ipn_params
    params.permit(:topic, :id, :token).to_h
  end

  def merchant_order_params
    params.permit(:merchant_order_id, :external_reference).to_h
  end
end
