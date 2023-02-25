Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  devise_for :user, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :comments, only: [:index, :show, :edit, :update, :destroy]
    resources :contributions, only: [:index, :show, :edit, :update, :destroy]
    get '/admin/users/:id/unsubscribe' => 'admin/users#unsubscribe', as: 'unsubscribe'
    patch '/admin/users/:id/withdrawal' => 'admin/users#withdrawal', as: 'withdrawal'
  end

  scope module: :public do
    root to: "homes#top"
    resources :users, only: [:index, :show, :edit, :update]
    resources :comments, only: [:create, :destroy]
    resources :contributions, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :follows, only: [:index, :create, :destroy]
    resources :favorits, only: [:create, :destroy]
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end