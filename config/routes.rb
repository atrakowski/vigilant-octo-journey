Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :admins
  devise_scope :admin do
    scope module: :admins, path: :admins, as: :admin do
      get 'dashboards/show', as: :root
      resources :admins
      resources :customers do
        patch 'unlock', on: :member
      end
    end
  end

  devise_for :customers, controllers: { registrations: 'customers/registrations' }
  devise_scope :customer do
    scope module: :customers, path: :customers, as: :customer do
      get 'dashboards/show', as: :root
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "home#index"
end
