Rails.application.routes.draw do

  devise_for :users
  mount ActionCable.server => '/cable'

  root 'chat_rooms#index'

  resources :chat_rooms, only: [:index, :create, :new, :show]

end
