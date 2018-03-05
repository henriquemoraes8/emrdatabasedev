Rails.application.routes.draw do

  devise_for :clinics, :path => 'clinics', :controllers => { sessions: "devise/clinics/sessions",
                                                             registrations: "devise/clinics/registrations",
                                                             passwords: "devise/clinics/passwords"}
  devise_for :insurances, :path => 'insurances', :controllers => { sessions: "devise/insurances/sessions",
                                                                   registrations: "devise/insurances/registrations",
                                                                   passwords: "devise/insurances/passwords"}
  devise_for :users, :path => 'users', :controllers => { sessions: "devise/users/sessions",
                                                         registrations: "devise/users/registrations",
                                                         passwords: "devise/users/passwords"}
  resource :user, only: [:create] do
    member do
      get :records
      resources :clinic, only: [] do
        get :records, to: 'users#records_by_clinic'
      end
    end
    post :login, :validate
  end

  resource :clinic, only: [:create] do
    post :login
    resources :users, :controller => :clinics, only: [] do
      get :records
      post :record, to: 'clinics#upload_file'
      resources :clinic, only: [] do
        get :records, to: 'clinics#records_by_clinic'
      end
    end

    resource :requests, :controller => :clinics, only: [] do
      get :pending, :approved
    end

    resource :users, :controller => :clinics, only: [] do
      post :search, :full_search
    end
  end

  resource :insurance, only: [:create] do
    post :login
    resources :users, :controller => :insurances, only: [] do
      get :records
      resources :clinic, :controller => :insurances, only: [] do
        get :records, to: 'insurances#records_by_clinic'
      end
    end
    resources :user, :controller => :insurances, only: [] do
      post :search, to: 'insurances#search_users'
    end
  end

end
