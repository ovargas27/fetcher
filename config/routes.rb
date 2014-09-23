Rails.application.routes.draw do
  root 'pages#index'

  resources :pages, only: [:index, :create] do
    resources :posts, only: [:index]
  end
end
