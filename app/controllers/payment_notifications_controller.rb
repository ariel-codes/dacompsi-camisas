class PaymentNotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def notify
    order = Order.find_by!(id: params[:order_id], token: params[:token])
    PaymentService.new(order).process_payment_notification(ipn_params)

    head :ok
  end

  def ipn_params
    params.permit(:topic, :id, :token)
  end
end
