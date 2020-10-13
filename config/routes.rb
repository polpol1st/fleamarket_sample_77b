Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'

  get 'users/show'

  devise_for :users ,controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  resources :category, only: [:show,:index]



  resources :cards, only: [:new, :show, :destroy] do
    collection do
      post 'pay', to: 'cards#pay'
    end
  end

  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      get 'done', to: 'purchase#done'
      post 'pay', to: 'purchase#pay'
    end
  end

  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items, only: [:new, :create, :edit, :update, :show, :destroy] do
    resources :likes, only: [:index, :create, :destroy]
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

  resources :users, only: [:show]
  get '*wrong_routes', to: 'routing_errors#index'

end
