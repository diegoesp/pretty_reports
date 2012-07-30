PrettyReports::Application.routes.draw do

  resources :items

  root to: "home#index"

  resources :reports

end
