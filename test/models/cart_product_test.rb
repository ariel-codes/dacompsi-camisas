require "test_helper"

class CartProductTest < ActiveSupport::TestCase
  test "validates variations" do
    shirt = Product.new name: "Test Shirt", price: 100, thumb_path: "test.jpg", carousel_paths: ["test.jpg"],
      variations: {"curso" => ["CC"], "corte" => ["t-shirt"], "tamanho" => ["S"], "cor" => ["preto"]}

    cart_product = CartProduct.new product: shirt, quantity: 1,
      variations: {"curso" => "CC", "corte" => "t-shirt", "tamanho" => "S", "cor" => "preto"}

    cart_product.validate
    assert_empty cart_product.errors[:variations]

    invalid_cart_product = CartProduct.new product: shirt, quantity: 1,
      variations: {"curso" => "MC", "corte" => "gola v", "tamanho" => "S", "cor" => "preto"}

    invalid_cart_product.validate
    assert_not_empty invalid_cart_product.errors[:variations]
  end
end
