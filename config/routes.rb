Rails.application.routes.draw do
  root "pages#home"
  devise_for :customers, :controllers => { registrations: 'registrations' }
  get 'operations/new_deposit', to: 'operations#new_deposit', as: "deposit"
  post 'operations/new_deposit', to: 'operations#create_deposit'
  get 'operations/new_withdraw', to: 'operations#new_withdraw', as: "withdraw"
  post 'operations/new_withdraw', to: 'operations#create_withdraw'
  get 'operations/new_transfer', to: 'operations#new_transfer', as: "transfer"
  post 'operations/new_transfer', to: 'operations#create_transfer'
  resources :operations, only: [:show, :index] do
    collection do
      match 'search' => 'operations#search', via: [:get, :post], as: :search
    end
  end
  resources :accounts, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
