class OrderMailer < ApplicationMailer
  has_history user: -> { params[:order].buyer }
  track_clicks campaign: "order-confirmations", only: [:confirmation]
  utm_params

  def confirmation
    @order = params[:order]
    @buyer = @order.buyer
    @order_items = @order.cart_products

    mail to: @buyer.email, subject: subject("Confirmação de Compra")
  end

  def paid
    @order = params[:order]

    mail to: @order.buyer.email, subject: subject("Confirmação de Pagamento")
  end

  def failed
    @order = params[:order]

    mail to: @order.buyer.email, subject: subject("Erro no Pagamento")
  end

  def cancelled
    @order = params[:order]

    mail to: @order.buyer.email, subject: subject("Pedido Cancelado")
  end

  private

  def subject(action)
    "[DACompSI] #{action} - Pedido ##{@order.id}"
  end
end
