Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :user, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :contributions, only: [:index, :show, :update, :destroy] do
      resources :comments, only: [:destroy]
    end
  end

  scope module: :public do
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :follows, only: [:index]
    post 'follow/:id' => 'follows#follow', as: 'follow'
    post 'unfollow/:id' => 'follows#unfollow', as: 'unfollow'
    get "search" => "searches#search"
    resources :contributions, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end