class OrderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.new.subject

  def confirmation
    @buyer = params[:buyer]
    @order = params[:order]
    @order_items = @order.cart_products

    mail to: @buyer.email, subject: "[DACompSI] Confirmação de Compra - Pedido ##{order.id}}"
  end

  def paid
    @order = params[:order]

    mail to: @order.buyer.email, subject: "[DACompSI] Confirmação de Pagamento - Pedido ##{order.id}}"
  end

  def error
    @order = params[:order]

    mail to: @order.buyer.email, subject: "[DACompSI] Erro no Pagamento - Pedido ##{order.id}}"
  end
end
