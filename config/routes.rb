Rails.application.routes.draw do
  resources :questions
  resources :users

  root to: 'questions#index'
end
