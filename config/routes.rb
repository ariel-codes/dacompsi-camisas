Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resource :cart, only: [:show], path: "carrinho" do
    post :add_product
    post :change_quantity
    get :checkout
  end

  resources :orders, only: [:index, :show, :create], path: "pedidos" do
    get :public_link, on: :collection, path: "link-publico"
  end

  resources :payment_notifications, param: :order_id, only: [] do
    post :ipn
    get :after_redirect
  end

  resources :campaigns, path: "campanhas", only: [:index, :show] do
    resources :products, only: [:show], path: "produtos"
  end

  resources :products, only: [:show], path: "produtos"

  delete :logout, to: "application#logout", path: "esquecer"

  # Defines the root path route ("/")
  root "campaigns#index"
end
