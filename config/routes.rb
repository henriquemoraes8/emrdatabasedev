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
    post "/insurances/sign_in" => "devise/insurances/sessions#create", :as => :insurance_session
    delete "/insurances/sign_out" => "devise/insurances/sessions#destroy", :as => :destroy_insurance_session
    post "/insurances" => "devise/insurances/registrations#create", :as => :create_insurance
    patch "/insurances" => "devise/insurances/registrations#update", :as => :update_insurance
  end

  devise_for :users, skip: [:sessions, :registrations, :passwords, :confirmations, :omniauth_callbacks, :unlocks]

  as :user do
    post "/users/sign_in" => "devise/users/sessions#create", :as => :user_session
    delete "/users/sign_out" => "devise/users/sessions#destroy", :as => :destroy_user_session
    post "/users" => "devise/users/registrations#create", :as => :create_user
    patch "/users" => "devise/users/registrations#update", :as => :update_user
    post "/users/forgot_password" => "devise/users/registrations#forgot_password", :as => :forgot_password_user
    post "/users/password" => "devise/users/registrations#password", :as => :change_password_user
    get "/users/email_exists" => "devise/users/registrations#email_exists?", :as => :exists_email_user
    get "/users/phone_exists" => "devise/users/registrations#phone_exists?", :as => :exists_phone_user
  end

  resource :user, only: [:update] do
    get :records, :clinics, :requests
    resources :clinics, only: [] do
      get :records, to: 'users#records_by_clinic'
    end
    resources :requests, param: :token, only: [] do
      post :approve, to: 'users#approve_request'
      post :deny, to: 'users#deny_request'
      get :info, to: 'users#info_by_request_token'
      patch :consent_form, to: 'users#consent_form'
    end
  end

  resources :users, only: [] do
    post :validate, :verify, :password
  end

  resource :clinic, only: [:update] do
    resources :users, :controller => :clinics, only: [] do
      get :records
      get :details, to: 'clinics#user_details'
      post :record, to: 'clinics#upload_file'

      resource :access, only: [] do
        post :sms, to: 'clinics#access_phone'
        post :email, to: 'clinics#access_email'
        post :verify_and_email, to: 'clinics#verify_user_and_email'
        post :verify_and_message, to: 'clinics#verify_user_and_message'
      end

      resources :clinic, only: [] do
        get :records, to: 'clinics#records_by_clinic'
      end

      patch 'insurances/:insurance_id', to: 'clinics#add_user_to_insurance'

    end

    resource :requests, :controller => :clinics, only: [] do
      get :pending, :approved
    end

    delete 'records/:record_id', to: 'clinics#delete_record'

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

  resources :insurances, only: [:index]

  resources :record_types, only: [:index]

end
