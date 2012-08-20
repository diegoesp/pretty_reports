PrettyReports::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :users 
  devise_scope :user do get '/users/sign_out' => 'devise/sessions#destroy' end

  root to: "home#index"

  resources :reports do
    member do
      get 'download'
    end
  end

end
