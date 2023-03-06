Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resource :cart, only: [:show], path: "carrinho" do
    post :add_product, path: "adicionar-produto"
    post :change_quantity, path: "alterar-quantidade"
  end

  resources :campaigns, path: "campanhas", only: [:index, :show] do
    resources :products, only: [:show], path: "produtos"
  end

  resources :products, only: [:show], path: "produtos"

  # Defines the root path route ("/")
  root "campaigns#index"
end
