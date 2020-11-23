Rails.application.routes.draw do
  root 'homes#top'
  get '/about' => 'homes#about'
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :items do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :users
  get 'user/favo' => 'users#favo'
  get 'user/withdrawal' => 'users#withdrawal'

  get 'search' => 'searchs#search'
end
