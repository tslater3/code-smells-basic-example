Rails.application.routes.draw do
  resources :owners
  resources :cats

  root 'owners#index'
end
