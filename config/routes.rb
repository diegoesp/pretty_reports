PrettyReports::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :users 
  devise_scope :user do get '/users/sign_out' => 'devise/sessions#destroy' end

  root to: "home#index"
  match "/pdfkit", :to => "home#pdfkit"
  match "/pdf", :to => "home#pdf"

  resources :reports do
    member do
      get 'download'
      get 'download_available', path: 'download-available'
    end
  end

end