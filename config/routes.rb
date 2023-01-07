Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    put :toggle_hide, on: :member
    # member do
    #
    # end
    # get :hashtags, on: :member
    # get 'hashtags/:name', :action => 'hashtags'
  end

  get "/questions/hashtags/:name", to: "questions#hashtags"

  resource :session, only: %i[new create destroy]
  resources :users, except: %i[index]
end
