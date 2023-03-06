Rails.application.routes.draw do
  resources :carts
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :campaigns, path: "campanha", only: [:index, :show] do
    resources :products, only: [:show, :create]
  end

  # Defines the root path route ("/")
  root "campaigns#index"
end
