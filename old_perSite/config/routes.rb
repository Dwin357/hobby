Rails.application.routes.draw do
  
  root "castles#road"
  get "road" => "castles#road"
  get "courtyard" => "castles#courtyard"

  # sessions
  get 'login' => "sessions#new"
  post 'login' => "sessions#create"
  delete 'logout' => "sessions#destroy"
  resources :users

  get "gallery" => "paintings#index"
  resources :paintings
  
  get "study" => "posts#index"
  resources :posts

  get "gameRoom" => "castles#gameRoom"
  # need back end for program games

  get "workshop" => "projects#index"
  # need back end for idea-incubator
end
