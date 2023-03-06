require "application_system_test_case"

class ShirtsCurrentCampaignsTest < ApplicationSystemTestCase
  setup do
    @campaign = campaigns(:camisas_2023_1)
    travel_to @campaign.start.to_datetime
    freeze_time
  end

  test "visiting the index" do
    visit "/camisas"

    assert_link @campaign.name
  end
end
