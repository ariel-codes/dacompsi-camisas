# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

camisa23_1 = Product.create! price: 32_00, name: "Camisa de Curso",
  thumb_path: "camisa-thumb.png",
  carousel_paths: %w[camisa-cc.png camisa-si.png camisa-tamanhos.png],
  variations: {
    "corte" => %w[t-shirt babylook],
    "curso" => %w[Computação Sistemas],
    "cor" => %w[preto branco azul vinho cinza rosa petróleo verde],
    "tamanho" => %w[PP P M G GG XG]
  }

jaqueta23_1 = Product.create! price: 172_00, name: "Jaqueta DCC",
  thumb_path: "jaqueta-thumb.png",
  carousel_paths: %w[jaqueta-frente.png jaqueta-verso.png jaqueta-tamanhos.png],
  variations: {"tamanho" => %w[PP P M G GG]}

campanha23_1 = Campaign.create! name: "Camisas de Curso 2023/1",
  products: [camisa23_1, jaqueta23_1],
  start: Date.today,
  end: Date.today.next_week(:friday)
