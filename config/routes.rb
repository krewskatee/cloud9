Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }, skip: [:sessions]
  as :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    get 'signup', to: 'devise/registrations#new', as: :new_user
    get 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get 'chat_messages' => 'chat_messages#index'
  resource :chat_messages

  get '/' => 'posts#index'

  get '/post/:id' => 'posts#show'
  get '/post/:id/edit' => 'posts#edit'
  patch '/post/:id' => 'posts#update'

  get '/post' => 'posts#new'
  post '/post' => 'posts#create'
  get '/comment/:id/edit' => 'comments#edit'
  patch '/comment/:id' => 'comments#update'
  delete '/comment/:id' => 'comments#destroy'
  post '/comment' => 'comments#create'
  delete '/post/:id' => 'posts#destroy'

  mount ActionCable.server, at: '/cable'


end
