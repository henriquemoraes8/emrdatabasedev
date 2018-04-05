Rails.application.routes.draw do

  devise_for :clinics, skip: [:sessions, :registrations, :passwords, :confirmations, :omniauth_callbacks, :unlocks]

  as :clinic do
    post "/clinics/sign_in" => "devise/clinics/sessions#create", :as => :clinic_session
    delete "/clinics/sign_out" => "devise/clinics/sessions#destroy", :as => :destroy_clinic_session
    post "/clinics" => "devise/clinics/registrations#create", :as => :create_clinic
    patch "/clinics" => "devise/clinics/registrations#update", :as => :update_clinic
  end

  devise_for :insurances, skip: [:sessions, :registrations, :passwords, :confirmations, :omniauth_callbacks, :unlocks]

  as :insurance do
    post "/insurances/sign_in" => "devise/insurance/sessions#create", :as => :insurance_session
    delete "/insurances/sign_out" => "devise/insurance/sessions#destroy", :as => :destroy_insurance_session
    post "/insurances" => "devise/insurances/registrations#create", :as => :create_insurance
    patch "/insurances" => "devise/insurances/registrations#update", :as => :update_insurance
  end

  devise_for :users, skip: [:sessions, :registrations, :passwords, :confirmations, :omniauth_callbacks, :unlocks]

  as :user do
    post "/users/sign_in" => "devise/users/sessions#create", :as => :user_session
    delete "/users/sign_out" => "devise/users/sessions#destroy", :as => :destroy_user_session
    post "/users" => "devise/users/registrations#create", :as => :create_user
    patch "/users" => "devise/users/registrations#update", :as => :update_user
  end

  resource :user, only: [:update] do
    member do
      get :records, :clinics, :requests
      resources :clinics, only: [] do
        get :records, to: 'users#records_by_clinic'
      end
      resources :requests, param: :token, only: [] do
        post :approve, to: 'users#approve_request'
        post :deny, to: 'users#deny_request'
        get :info, to: 'users#info_by_request_token'
        patch :consent_form
      end
    end
  end

  resources :users, only: [] do
    post :validate, :verify
  end

  resource :clinic, only: [:update] do
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

  resource :insurance, only: [:update] do
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

  resources :record_types, only: [:index]

end
