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
  images: image_data(%w[camisa-cc.png camisa-si.png]),
  variations: {
    "corte" => %w[t-shirt babylook],
    "curso" => %w[Computação Sistemas],
    "cor" => %w[preto branco azul vinho cinza rosa petróleo verde],
    "tamanho" => %w[PP P M G GG XG]
  },
  description: <<~MARKDOWN.strip
    ## Camisa de curso dos cursos de Computação e Sistemas da UFMG.

    Camisa padrão da UFMG, com _Ciência da Computação_ ou _Sistemas de Informação_ bordado na frente e UFMG nas costas.
    Ideal pra quem quer vestir a camisa do curso com conforto e comodidade para seu dia-a-dia.

    ### Vantagens
    - Não desbota ou perde a cor com o tempo
    - Não encolhe após as lavagens
    - Não dá bolinhas no tecido
    - Não amarrota

    ### FAQ
    |      P:             |            R:                           |
    |---------------------|-----------------------------------------|
    | Material            | 65% poliéster e 35% viscose             |
    | Prazo de Entrega    | 20 dias úteis após fechamento do pedido |
    | Entrega e Retirada  | Na sala do DA (2038)                    |

    ### Tamanhos
    | Tamanho | Comprimento | Largura |
    |---------|-------------|---------|
    | PP      | 68cm        | 47cm    |
    | P       | 71cm        | 51cm    |
    | M       | 73cm        | 54cm    |
    | G       | 75cm        | 56cm    |
    | GG      | 80cm        | 59cm    |
    | XG      | 81cm        | 63cm    |
  MARKDOWN

jaqueta23_1 = Product.create! price: 172_00, name: "Jaqueta DCC",
  images: image_data(%w[jaqueta-frente.png jaqueta-verso.png]),
  variations: {"tamanho" => %w[PP P M G GG]},
  description: <<~MARKDOWN.strip
    ## LANÇAMENTO
    ## Jaqueta do Departamento de Ciência da Computação da UFMG.

    Tecido de moletom quentinho, e o mais importante, a estampa do DCC bordada no peito e da UFMG nas costas.

    ### FAQ
    |      P:            |             R:                          |
    |--------------------|-----------------------------------------|
    | Material           | 50% Algodão e 50% Poliéster             |
    | Estampa            | Logotipo DCC na frente, e UFMG atrás    |
    | Prazo de Entrega   | 20 dias úteis após fechamento do pedido |
    | Entrega e Retirada | Na sala do DA (2038)                    |

    ### Tamanhos
    | Tamanho | Comprimento | Largura |
    |---------|-------------|---------|
    | PP      | 63cm        | 54cm    |
    | P       | 68cm        | 56cm    |
    | M       | 73cm        | 59cm    |
    | G       | 78cm        | 61cm    |
    | GG      | 82cm        | 65cm    |
  MARKDOWN

campanha23_1 = Campaign.create! name: "Camisas de Curso 2023/1",
  products: [camisa23_1, jaqueta23_1],
  start: Date.today,
  end: Date.today.next_occurring(:sunday)
