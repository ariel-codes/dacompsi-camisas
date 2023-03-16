class OrderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.new.subject

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
