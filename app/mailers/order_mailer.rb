class OrderMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.new.subject
  #
  def confirmation
    @buyer = params[:buyer]
    @order = params[:order]
    @order_items = @order.cart_products

    mail to: @buyer.email, subject: "[DACompSI] Confirmação de Compra"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.paid.subject
  #
  def paid
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.fulfilled.subject
  #
  def fulfilled
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.delivered.subject
  #
  def delivered
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
