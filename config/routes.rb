PrettyReports::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' end

  root to: "reports#new"

  resources :reports do
    member do
      get 'download'
    end
  end

end
