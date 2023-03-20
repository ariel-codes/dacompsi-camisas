require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment_service_mock = Minitest::Mock.new
    @payment_service_mock.expect :create_payment, "https://example.com/redirect_mp", [],
      notification_url: String, back_url: String
  end

  test "#create with an existing buyer" do
    buyer = buyers(:ariel)
    cart = carts(:ariel_cart)
    second_email = "another@email.com"

    assert_difference -> { Order.count }, 1 do
      assert_changes -> { buyer.reload.email }, from: buyer.email, to: second_email do
        PaymentService.stub :new, @payment_service_mock do
          post orders_url, params: {buyer: {name: buyer.name, email: second_email, telephone: buyer.telephone}, cart_id: cart.id}
        end
      end
    end
  end
end
