PrettyReports::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :users
  devise_scope :user do get '/users/sign_out' => 'devise/sessions#destroy' end

  root to: "home#index"

  get '/home' => 'home#index'
  get '/static-pages/about-us' => 'static_pages#about_us'
  get '/static-pages/welcome' => 'static_pages#welcome', as: 'welcome_page'

  resources :reports do
    member do
      get 'download'
      get 'download_available', path: 'download-available'
    end
  end

  resources :users

  resources :imports

end
