PrettyReports::Application.routes.draw do

  root to: "reports#new"

  resources :reports do
    member do
      get 'download'
    end
  end

end
