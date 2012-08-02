PrettyReports::Application.routes.draw do

  root to: "home#index"

  resources :reports do
    member do
      get 'download'
    end
  end

end
