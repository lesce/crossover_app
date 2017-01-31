Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    sessions: 'api/v1/sessions',
    registrations: 'api/v1/registrations',
    passwords: 'api/v1/passwords'
  }

  namespace :api do
    namespace :v1 do
      resources :tickets, only: [:index, :show, :create, :update, :destroy] do
        member do
          patch :change_status
        end
      end
    end
  end
end
