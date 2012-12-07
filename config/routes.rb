Drug::Application.routes.draw do
  resources :sessions, only: [:create] do
    delete 'destroy', on: :collection
  end
  match "/auth/:provider/callback", to: "sessions#create"

  root to: "home#index"
  resources :users, only: [:index, :show]

  resources :events, only: [:index, :show] do
    resources :attendants, only: [:index, :create] do
      delete 'destroy', on: :collection
    end
    resources :presentations, only: [:create, :destroy] do
      member do
        post 'cancel_postponement'
        post 'postpone'
      end
    end
  end
  resource :contact, only: [:show, :create]
end
