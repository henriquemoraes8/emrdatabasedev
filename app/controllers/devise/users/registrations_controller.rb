# frozen_string_literal: true
module Devise
  class Users::RegistrationsController < Devise::RegistrationsController
    #include Accessible

    before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, :authenticate, only: [:update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      super do |resource|
        render json: { user: resource }.to_json and return
      end
    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :birth_date, :phone, :social, address: [:street, :city, :zip, :apt, :state]])
    end

    # If you have extra params to permit, append them to the sanitizer.
    def configure_account_update_params
      params.require(:user).permit([:name, :last_name, :phone, :birth_date, :password, :password_confirmation, :current_password, address: [:street, :city, :zip, :apt, :state]])
    end

    def authenticate
      @user = User.find_by_email("r@gmail.com")#authentication_token(request.headers['X-TOKEN'])
      render json: {message: "user does not exist"}, :status => 401 if @user.nil?
    end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end

