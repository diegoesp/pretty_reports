PrettyReports::Application.routes.draw do

  root to: "reports#index"

  resources :reports do
    member do
      get 'download'
      get 'download_available', path: 'download-available'
    end
  end

end
