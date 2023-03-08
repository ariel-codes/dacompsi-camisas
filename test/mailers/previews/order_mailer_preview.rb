# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/new
  def new
    OrderMailer.new
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/paid
  def paid
    OrderMailer.paid
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/fulfilled
  def fulfilled
    OrderMailer.fulfilled
  end

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/delivered
  def delivered
    OrderMailer.delivered
  end
end
