Rails.application.routes.draw do

  get 'insurances/search_users'

  get 'insurances/create'

  get 'insurances/login'

  get 'insurances/records'

  get 'insurances/records_by_clinic'

  get 'insurances/search_user'

  get 'clinics/create'

  get 'clinics/login'

  get 'clinics/records'

  get 'clinics/records_by_clinic'

  get 'clinics/upload_file'

  get 'clinics/search_users_by_clinic'

  get 'clinics/search_users'

  get 'users/create'

  get 'users/login'

  get 'users/records'

  get 'users/records_by_clinic'

  get 'users/validate'

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
    resources :users, only: [] do
      get :records
      resources :clinic, only: [] do
        get :records
      end
    end
    resources :user, only: [] do
      post :search
    end
  end

end
