require "test_helper"

class OrderMailerTest < ActionMailer::TestCase
  setup do
    @buyer = Buyer.create! name: "John", email: "john@email.com", telephone: "31 99999-9999"
    cart = Cart.create! cart_products: [
      CartProduct.new(product: products(:camisa), quantity: 1, variations: {
        curso: "Computação", tamanho: "M", cor: "verde", corte: "t-shirt"
      }),
    ]
    @order = Order.create! cart:, buyer: @buyer, total_price: cart.total_price
  end

  test "confirmation" do
    email = OrderMailer.with(order: @order, buyer: @buyer).confirmation

    assert_emails 1 do
      email.deliver_now
    end
  end

  test "paid" do
    @order.payment_completed!
    email = OrderMailer.with(order: @order).paid

    assert_emails 1 do
      email.deliver_now
    end
  end

  test "failed" do
    @order.payment_failed!
    email = OrderMailer.with(order: @order).failed

    assert_emails 1 do
      email.deliver_now
    end
  end
end
