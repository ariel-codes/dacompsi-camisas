require "application_system_test_case"
require "mercadopago"

class PurchaseTest < ApplicationSystemTestCase
  include ActionMailer::TestHelper

  MP_REDIRECT_PATH = "https://example.com/redirect_mp"
  MERCHANT_ORDER_ID = "M-1"

  attr_accessor :campaign, :order, :preference_mock, :merchant_order_mock, :back_url

  setup do
    self.campaign = campaigns(:camisas_active)

    self.preference_mock = Minitest::Mock.new
    self.merchant_order_mock = Minitest::Mock.new
  end

  def mailer_args
    {order:}
  end

  test "full purchase flow" do
    visit "/"
    click_on campaign.name

    click_on campaign.products.first.name

    click_on "Adicionar ao Carrinho"

    click_on "Finalizar Compra"

    fill_in "Nome", with: "Fulano"
    fill_in "Email", with: "fulano@test.com"
    fill_in "Telefone", with: "31999999999"

    ::Mercadopago::Preference.stub :new, preference_mock do
      preference_mock.expect :create, {response: {"init_point" => MP_REDIRECT_PATH}} do |preference_params|
        # notification_url = preference_params[:notification_url]
        self.back_url = preference_params[:back_urls][:success]
      end

      assert_changes -> { Order.count }, from: Order.count, to: Order.count + 1 do
        click_on "Pagar"
      end
      self.order = Order.last

      assert_enqueued_email_with OrderMailer, :confirmation, args: mailer_args

      assert order.payment_pending?
      assert_current_path "/redirect_mp"
    end

    ::Mercadopago::MerchantOrder.stub :new, merchant_order_mock do
      merchant_order_mock.expect(:get,
        {response: {"order_status" => "paid", "external_reference" => order.id}},
        [MERCHANT_ORDER_ID])

      assert_enqueued_email_with OrderMailer, :paid, args: mailer_args do
        visit back_url + "&merchant_order_id=#{MERCHANT_ORDER_ID}&external_reference=#{order.id}"
        assert order.reload.payment_completed?
      end
    end
  end
end
