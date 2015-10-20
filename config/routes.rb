Rails.application.routes.draw do

  resources :labels, only: [:show]

  resources :rates, only: [:show]
  
  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  
  resources :topics do
    resources :sponsored_posts
  end

  resources :sponsored_posts

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]
  
  resources :advertisements, only: [:index, :show, :new, :create]
  
  resources :questions

  post 'confirm' => 'users#confirm'
  
  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  root to: 'welcome#index'
end
