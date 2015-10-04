Rails.application.routes.draw do

  resources :advertisements, only: [:index, :show, :new, :create]
  resources :topics do
    resources :posts, except: [:index]
  end

  resources :questions

  get 'about' => 'welcome#about'

  get 'welcome/contact'

  get 'welcome/faq'

  root to: 'welcome#index'
end
