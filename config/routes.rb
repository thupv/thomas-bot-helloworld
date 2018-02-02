Rails.application.routes.draw do
  get 'callback/index'

  get 'callback/receive_data'
  post '/', to: 'callback#receive_data'
  root to: 'callback#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
