require "application_system_test_case"

class ShirtsCurrentCampaignsTest < ApplicationSystemTestCase
  setup do
    @campaign = campaigns(:camisas_2023_1)
    travel_to @campaign.start.to_datetime
    freeze_time
  end

  test "visiting the index" do
    visit "/campanhas"
    click_on Campaign.first.name

    click_on Campaign.first.products.first.name

    click_on "Adicionar ao Carrinho"

    click_on "Finalizar Compra"

    fill_in "Nome", with: "Fulano"
    fill_in "Email", with: "fulano@test.com"
    fill_in "Telefone", with: "31 99999-9999"

    assert_changes -> { Order.count }, from: Order.count, to: Order.count + 1 do
      click_on "Pagar"
    end
    assert Order.last.payment_pending?
    # jfc MercadoPago is shit
    assert_current_path "/redirect_mp"
  end
end
