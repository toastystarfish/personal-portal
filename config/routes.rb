Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :users
  devise_scope :user do
    get '/users/new/:token', controller: 'users', action: 'new',
                       as: 'invited_new_user'

    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_out', to: 'devise/sessions#destroy'
  end

  resources :invitations, only: [:new, :create]

  get '/home', to: 'home#show'

  root 'home#show'
end
