PrettyReports::Application.routes.draw do

  root to: "home#index"

  resources :reports

end
