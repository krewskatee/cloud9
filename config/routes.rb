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
      get '/posts' => 'posts#index'
      get '/comment' => 'comments#index'
      post '/comment' => 'comments#create'
      get '/comment/:id' => 'comments#show'
      patch '/comment/:id' => 'comments#update'
      delete '/comment/:id' => 'comments#destroy'
    end
  end

  post '/chat_messages' => 'chat_messages#create'

  get '/chats' => 'chats#index'
  post '/chats' => 'chats#create'
  get '/chats/:id' => 'chats#show'
  delete '/chats/:id' => 'chats#destroy'

  get '/' => 'posts#index'

  get '/posts/new' => 'posts#new'
  post '/post' => 'posts#create'
  get '/post/:id' => 'posts#show'
  get '/post/:id/edit' => 'posts#edit'
  patch '/post/:id' => 'posts#update'
  delete '/post/:id' => 'posts#destroy'

  post '/comment' => 'comments#create'
  patch '/comment/:id' => 'comments#update'
  delete '/comment/:id' => 'comments#destroy'

  post '/friends' => 'relationships#create'
  patch '/friends/decision/:id' => 'relationships#friend_decision'
  delete '/friends/delete/:id' => 'relationships#delete_friend'
  delete '/friends/:id' => 'relationships#destroy'

  post '/user_chats' => 'user_chats#create'
  patch '/comment/:id' => 'comments#update'
  delete '/user_chats/:id/:chat_id' => 'user_chats#destroy'

  mount ActionCable.server, at: '/cable'
  get '*path' => redirect('/')
end
