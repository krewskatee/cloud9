Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }, skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    get 'signup', to: 'devise/registrations#new', as: :new_user
    get 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  namespace :api do
    namespace :v1 do
      get '/post/:id' => 'posts#show'
      get '/comment' => 'comments#index'
      get '/comment/:id' => 'comments#show'
      post '/comment' => 'comments#create'
      patch '/comment/:id' => 'comments#update'
      delete '/comment/:id' => 'comments#destroy'
    end
  end

  post '/chat_messages' => 'chat_messages#create'


  get '/chats' => 'chats#index'
  get '/chats/:id' => 'chats#show'
  post '/chats' => 'chats#create'
  delete '/chats/:id' => 'chats#destroy'

  get '/' => 'posts#index'

  get '/post/:id' => 'posts#show'
  get '/post/:id/edit' => 'posts#edit'
  patch '/post/:id' => 'posts#update'

  get '/post' => 'posts#new'
  post '/post' => 'posts#create'
  delete '/post/:id' => 'posts#destroy'

  post '/comment' => 'comments#create'
  get '/comment/:id/edit' => 'comments#edit'
  patch '/comment/:id' => 'comments#update'
  delete '/comment/:id' => 'comments#destroy'



  get '/friends' => 'relationships#index'
  get '/friends/new' => 'relationships#new'
  post '/friends' => 'relationships#create'
  patch '/friends/decision/:id' => 'relationships#friend_decision'
  delete '/friends/:id' => 'relationships#destroy'

  post '/user_chats' => 'user_chats#create'
  delete '/user_chats' => 'user_chats#destroy'

  patch '/comment/:id' => 'comments#update'

  mount ActionCable.server, at: '/cable'


end
