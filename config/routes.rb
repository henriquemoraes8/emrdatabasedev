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
  resource :user, only: [] do
    member do
      get :records, :clinics, :requests
      resources :clinics, only: [] do
        get :records, to: 'users#records_by_clinic'
      end
      resources :requests, param: :token, only: [] do
        post :approve, to: 'users#approve_request'
        post :deny, to: 'users#deny_request'
        get :info, to: 'users#info_by_request_token'
      end
    end
  end

  resources :users, only: [] do
    post :validate, :verify
  end

  resource :clinic, only: [] do
    resources :users, :controller => :clinics, only: [] do
      get :records
      get :details, to: 'clinics#user_details'
      post :record, to: 'clinics#upload_file'

      resource :access, only: [] do
        post :sms, to: 'clinics#access_phone'
        post :email, to: 'clinics#access_email'
      end

      resources :clinic, only: [] do
        get :records, to: 'clinics#records_by_clinic'
      end
    end

    resource :requests, :controller => :clinics, only: [] do
      get :pending, :approved
    end

    resource :search, :controller => :clinics, only: [] do
      post :users, to: 'clinics#search_users'
      post :all_users, to: 'clinics#search_all_users'
    end
  end

  resource :insurance, only: [] do
    resources :users, :controller => :insurances, only: [] do
      get :records
      get :details, to: 'insurances#user_details'
      resources :clinic, :controller => :insurances, only: [] do
        get :records, to: 'insurances#records_by_clinic'
      end
    end
    resource :search, :controller => :clinics, only: [] do
      post :users, to: 'insurances#search_users'
    end
  end

end
