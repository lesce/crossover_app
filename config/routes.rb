Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { 
    sessions: 'user/sessions',
    registrations: 'user/registrations',
    passwords: 'user/passwords'
  }

  namespace :api do
    namespace :v1 do
      resources :tickets, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
