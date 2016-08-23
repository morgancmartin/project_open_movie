Rails.application.routes.draw do
  root 'users#show'
  devise_for :users
  resources :users
  get '/search_results' => 'search_results#index'
  get '/movie' => 'search_results#show'
  get '/advanced_show' => 'search_results#advanced_show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
