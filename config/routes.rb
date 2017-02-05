Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :home, only: [:index] do
    collection do
      get :test
    end
  end
  devise_for :users, controllers: {
    sessions: 'api/v1/sessions',
    registrations: 'api/v1/registrations',
    passwords: 'api/v1/passwords'
  }

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :update]
      resources :tickets, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get :reports
        end
      end
    end
  end
end
