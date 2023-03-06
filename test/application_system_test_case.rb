require "test_helper"
require "capybara/cuprite"

Capybara.default_max_wait_time = 2
Capybara.default_normalize_ws = true

Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    window_size: [360, 640],
    browser_options: {},
    process_timeout: 10,
    inspector: true,
    # Allow running Chrome in a headful mode by setting HEADLESS env
    # var to a falsey value
    headless: !ENV["HEADLESS"].in?(%w[n 0 no false])
  )
end
Capybara.default_driver = Capybara.javascript_driver = :cuprite

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite
end
