Rails.application.routes.draw do
  resources :contacts
  root to: 'blogs#new'
  resources :blogs do
    collection do
      post :confirm
    end
  end
  
Rails.application.routes.draw do
  resources :contacts
  resources :sessions, only: [:new, :create, :destroy]
  resources :users
  resources :favorites, only: [:create, :destroy]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  end
end