Rails.application.routes.draw do

  devise_for :users

  resources :chat_rooms, only: [:index, :create, :new]
end
