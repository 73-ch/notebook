Rails.application.routes.draw do
  resources :users, only: [:show, :new, :edit, :create, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  match 'signup', to: 'users#new', via: 'get'
  match 'destroy', to: 'users#destroy', via: 'delete'
  match 'signin', to: 'sessions#new', via: 'get'
  match 'signout', to: 'sessions#destroy', via: 'delete'

  root :to => 'home#top'

  resources :notes
  get '/new/:type/:source' => 'notes#new'
  post "/notes" => "notes#create"
  get "show_modal" => "notes#new", defaults: {format: "js"}
  delete "/note_destroy" => 'notes#destroy'

  get '/index_manager' => 'notes#index_manager'
  get '/index_all' => 'notes#index_all'
  get "/index_calender" => "notes#index_calender"
  get "/index_day" => "notes#index_day"
  get "/index_category" => "notes#index_category"

  get '/date/json' => 'notes#date_json'
  get '/particle/json' => 'notes#particle_json'


  get '/category/new/:type' => 'categories#new'
  get '/categories' => 'categories#index'
  post '/categories' => 'categories#create'
  delete '/category_destroy' => 'categories#destroy'
  get 'category/:id' => 'categories#show'


  get '/note/process/new/:note_id' => 'note_processes#new'
  post '/note_processes' => 'note_processes#create'
  delete '/note/process/destroy/:id' => 'note_processes#destroy'
  get '/note/process/edit/:id' => 'note_processes#edit'
  get '/note/process/update/:id' => 'note_processes#update'

end
