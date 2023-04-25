Rails.application.routes.draw do
  devise_for :users
  root to: "tweets#index"

  resources :tweets, only: %i[index create destroy] do
    member do
      post :retweet
    end
  end
  resources :profiles, only: %i[show]
end
