Rails.application.routes.draw do

  devise_for :users
  #root 'devise/sessions#new'
  devise_scope :user do
    authenticated :user do
      root 'transactions#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :transactions, except: [:show]

  resources :stats, only: [:index]
  resources :categories, except: [:show]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
