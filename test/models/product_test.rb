require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "variations is a list of properties and values" do
    product = Product.new name: "Test Product", price: 100,
      variations: {"color" => %w[red green blue]}
    product.validate
    assert_empty product.errors[:variations]

    invalid_product = Product.new name: "Test Product", price: 100,
      variations: {"color" => {red: :red}}
    invalid_product.validate
    assert_not_empty invalid_product.errors[:variations]
  end
end
