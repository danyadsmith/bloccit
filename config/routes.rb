Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
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
