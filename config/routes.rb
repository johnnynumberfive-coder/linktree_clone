Rails.application.routes.draw do
  patch 'links/:id' => 'links#update', as: :links
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
  }
  get 'dashboard', to: "dashboard#index"
  root 'dashboard#index'
  get 'appearance', to: "dashboard#appearance"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get ':id', to: 'dashboard#show', as: :user
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
