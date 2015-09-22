Rails.application.routes.draw do
  resources :users, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  match 'signup', to: 'users#new', via: 'get'
  match 'destroy', to: 'users#destroy', via: 'delete'
  match 'signin', to: 'sessions#new', via: 'get'
  match 'signout', to: 'sessions#destroy', via: 'delete'

  root 'users#index'
  get '/category' => 'categories#new'
  get '/categories' => 'categories#index'
  post '/categories' => 'categories#create'
  delete '/category_destroy' => 'categories#destroy'

  get 'category/:id' => 'categories#show'

  resources :notes
  get '/new' => 'notes#new'
  get '/new_date' => 'notes#new_date'
  get '/new_memo' => 'notes#new_memo'
  get '/new_message' => 'messages#new'
  get '/new_date_message' => 'messages#new_date'
  get '/new_memo_message' => 'messages#new_memo'
  get '/top' =>'home#top'
  post "/notes" => "notes#create"
  get '/index' => 'notes#index'
  get '/index_all' => 'notes#index_all'
  get "/index_importance" => "notes#index_importance"
  get "/index_particle" => "notes#index_particle"
  get 'messages' => 'messages#index'
  delete "/note_destroy" => 'notes#destroy'
  get "/index_date" => "notes#index_date"
  post "/messages" => "messages#create"
  get "/message/:id" => "messages#show"
  get '/follows' => "follows#index"
  get '/follows/new' => "follows#new"
  post '/follows' => 'follows#create'
end
