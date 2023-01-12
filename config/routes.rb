Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    put :toggle_hide, on: :member
  end

  get "/questions/hashtags/:name", to: "questions#hashtags"

  resource :session, only: %i[new create destroy]
  resources :users, except: %i[index], param: :nickname
end
