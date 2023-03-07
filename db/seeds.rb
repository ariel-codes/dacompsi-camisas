# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

camisa231 = Product.create! price: 3200, name: "Camisa de Curso",
  thumb_path: "camisa-thumb.png",
  carousel_paths: %w[camisa-cc.png camisa-si.png camisa-tamanhos.png],
  variations: {
    "curso" => %w[Computação Sistemas],
    "tamanho" => %w[S M G],
    "cor" => %w[branco preto verde],
    "corte" => %w[t-shirt babylook]
  }

jaqueta231 = Product.create! price: 3200, name: "Jaqueta DCC",
  thumb_path: "jaqueta-thumb.png",
  carousel_paths: %w[jaqueta-frente.png jaqueta-verso.png jaqueta-tamanhos.png],
  variations: {
    "curso" => %w[Computação Sistemas],
    "tamanho" => %w[S M G],
    "cor" => %w[branco preto verde],
    "corte" => %w[t-shirt babylook]
  }

campanha231 = Campaign.create! name: "Camisas de Curso 2023/1",
  products: [camisa231, jaqueta231],
  start: Date.new(2023, 03, 06),
  end: Date.new(2023, 03, 06).next_week(:friday)
