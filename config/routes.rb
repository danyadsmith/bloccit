Rails.application.routes.draw do
  
  resources :users, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy]

  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  resources :labels, only: [:show]

  resources :rates, only: [:show]
  
  resources :advertisements, only: [:index, :show, :new, :create]
  
  resources :questions do
    resources :answers
  end

  post 'confirm' => 'users#confirm'
  
  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  root to: 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :update]
      resources :topics, except: [:edit, :new]
      resources :posts, only: [:index, :show]
      resources :comments, only: [:index, :show]
    end
  end
end
