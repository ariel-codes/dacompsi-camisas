require "test_helper"

class ShirtTest < ActiveSupport::TestCase
  test "variations" do
    shirt_invalid = Shirt.new
    shirt = Shirt.new variations:
      {"print" => ["CC"], "cut" => ["t-shirt"], "size" => ["S"], "color" => ["preto"]}

    assert_not shirt_invalid.valid?
    assert shirt.valid?
  end
end
