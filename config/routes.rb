Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "ideas#index"
  resources :ideas, except: [:index] do
    resources :reviews, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
end
