# frozen_string_literal: true

module TokenSession
  extend ActiveSupport::Concern

  def retrieve_session_from_token
    @order = Order.find_by!(token: params[:token])
    @buyer = @order.buyer
    session[:buyer_id] = @buyer.id
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
