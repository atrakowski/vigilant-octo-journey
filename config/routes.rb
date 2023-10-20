Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :admins
  devise_scope :admin do
    scope module: :admins, path: :admins do
      get 'dashboards/show', as: :admin_root
    end
  end

  devise_for :customers
  devise_scope :customer do
    scope module: :customers, path: :customers do
      get 'dashboards/show', as: :customer_root
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "home#index"
end
