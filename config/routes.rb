Rails.application.routes.draw do
  root 'static_pages#index'

  namespace :api do
    namespace :v1 do
      resources :status, only: [:create, :update]

      resources :status_messages, only: [:create]
    end
  end
end
