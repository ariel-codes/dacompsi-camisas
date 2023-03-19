require "test_helper"

class CampaignTest < ActiveSupport::TestCase
  test ":active scope" do
    current = Campaign.create!(name: "Test", start: Date.today, end: Date.today + 1.day)
    past = Campaign.create!(name: "Test", start: Date.yesterday - 1.day, end: Date.yesterday)

    assert_includes Campaign.active, current
    assert_not_includes Campaign.active, past
  end
end
