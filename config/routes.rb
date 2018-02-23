Rails.application.routes.draw do

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
      post :record, :search, :full_search
      resources :clinic, only: [] do
        get :records
      end
    end

    resource :requests, only: [] do
      get :pending, :approved
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
