Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :carts

  resources :campaigns, path: "campanha", only: [:index, :show] do
    resources :products, only: [:show]
  end

  # Defines the root path route ("/")
  root "campaigns#index"
end
