# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
IMAGES_PATH = "app/assets/images/products/"

def image_data(*filenames)
  filenames.flatten!
  full_paths = filenames.map { |f| Rails.root.join(IMAGES_PATH, f) }
  filenames.map.with_index { |f, i| {io: File.open(full_paths[i]), filename: f} }
end

camisa23_1 = Product.create! price: 32_00, name: "Camisa de Curso",
  variations: {
    "corte" => %w[t-shirt babylook],
    "curso" => %w[Computação Sistemas],
    "cor" => %w[preto branco azul vinho cinza rosa petróleo verde],
    "tamanho" => %w[PP P M G GG XG]
  }
camisa23_1.thumbnail.attach image_data("camisa-thumb.png").first
camisa23_1.images.attach image_data(%w[camisa-cc.png camisa-si.png camisa-tamanhos.png])

jaqueta23_1 = Product.create! price: 172_00, name: "Jaqueta DCC",
  variations: {"tamanho" => %w[PP P M G GG]}
jaqueta23_1.thumbnail.attach image_data("jaqueta-thumb.png").first
jaqueta23_1.images.attach image_data(%w[jaqueta-frente.png jaqueta-verso.png jaqueta-tamanhos.png])

campanha23_1 = Campaign.create! name: "Camisas de Curso 2023/1",
  products: [camisa23_1, jaqueta23_1],
  start: Date.today,
  end: Date.today.next_occurring(:sunday)
