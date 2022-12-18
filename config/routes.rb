Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions, only: %i[index show new create edit update destroy] do
    put '/questions/:id', to: 'questions#hide'
  end

  resources :users
end
