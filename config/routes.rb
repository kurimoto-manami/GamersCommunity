Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :publics, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    resources :users
  end
  
  scope module: :public do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
