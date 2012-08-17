PrettyReports::Application.routes.draw do

  root to: "reports#index"

  resources :reports do
    member do
      get 'download'
    end
  end

end
