require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  test ":active scope" do
    current = Campaign.create!(name: "Test", start: Time.zone.now, end: Time.zone.now + 1.day)
    past = Campaign.create!(name: "Test", start: Time.zone.now - 1.day, end: Time.zone.now - 1.hour)

    assert_includes Campaign.active, current
    assert_not_includes Campaign.active, past
  end
end
