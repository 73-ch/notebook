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
  delete "/note_destroy" => 'notes#destroy'

  get '/index_manager' => 'notes#index_manager'
  get '/index_all' => 'notes#index_all'
  get "/index_importance" => "notes#index_importance"
  get "/index_particle" => "notes#index_particle"
  get "/index_calender" => "notes#index_calender"
  get "/index_day" => "notes#index_day"

  get '/date/json' => 'notes#date_json'
  get '/particle/json' => 'notes#particle_json'


  get '/category/new/:type' => 'categories#new'
  get '/categories' => 'categories#index'
  post '/categories' => 'categories#create'
  delete '/category_destroy' => 'categories#destroy'
  get 'category/:id' => 'categories#show'


  get '/new_message' => 'messages#new'
  get '/new_date_message' => 'messages#new_date'
  get '/new_memo_message' => 'messages#new_memo'
  get 'messages' => 'messages#index'
  post "/messages" => "messages#create"
  get "/message/:id" => "messages#show"


  get '/follows' => "follows#index"
  get '/follows/new' => "follows#new"
  post '/follows' => 'follows#create'


  get 'belong_user_to_groups' => 'belong_user_to_groups#index'
  post 'belong_user_to_groups' => 'belong_user_to_groups#create'
  get '/group/joining/new' => 'belong_user_to_groups#new'


  get '/group/new' => 'groups#new'
  get 'group/:id/show' => 'groups#show'
  post 'groups' => 'groups#create'
  get 'groups' => 'groups#index'
  delete 'group/destroy/:id' => 'groups#destroy'


  get 'invite/new' => 'invite_groups#new'
  post 'invite_groups' => 'invite_groups#create'
  get 'invite/index' => 'invite_groups#index'
  delete 'invite/destroy/:id' => 'invite_groups#destroy'


  get 'group/:id' => 'group_notes#index'
  get 'group_notes_all/:id' => 'group_notes#index_all'
  get 'group_note/new' => 'group_notes#new'
  get 'group_note/new_date' => 'group_notes#new_date'
  get 'group_note/new_memo' => 'group_notes#new_memo'
  post 'group_notes' => 'group_notes#create'
  delete 'group_note/destroy/:id' => 'group_notes#destroy'
  get 'group/event/json' => 'group_notes#event_json'
  get 'group_note/edit/:id' => 'group_notes#edit'
  get 'group_note/:id' => 'group_notes#show'


  get '/note/process/new/:note_id' => 'note_processes#new'
  post '/note_processes' => 'note_processes#create'
  delete '/note/process/destroy/:id' => 'note_processes#destroy'
  get '/note/process/edit/:id' => 'note_processes#edit'
  get '/note/process/update/:id' => 'note_processes#update'

end
