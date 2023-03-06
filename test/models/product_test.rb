require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "variations is a list of properties and values" do
    product = Product.new
    product.variations = {"color" => %w[red green blue]}

    assert_not product.valid?
  end
end
