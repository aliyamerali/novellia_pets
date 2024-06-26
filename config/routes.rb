Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  namespace :admin do
    resources :pets, only: [:index]
  end

  namespace :user do
    scope '/:user_id' do
      resources :pets, only: [:create, :index, :new]
      resources :allergy_records, only: [:create, :new]
      resources :allergy_reactions, only: [:create, :new]
      resources :vaccine_records, only: [:create, :new]
    end
  end
end
