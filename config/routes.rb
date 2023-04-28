Rails.application.routes.draw do
  devise_for :users
  root to: "tweets#index"

  resources :tweets, except: %i[edit update] do
    resources :comments, only: %i[create destroy]
    member do
      post :retweet
    end
  end

  resources :profiles, only: %i[show]
  resources :likes, only: %i[create]
end
