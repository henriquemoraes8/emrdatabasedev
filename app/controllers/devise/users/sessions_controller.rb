# frozen_string_literal: true

module Devise
  class Users::SessionsController < Devise::SessionsController
    #protect_from_forgery with: :null_session
    #include Accessible
    #skip_before_action :check_session, only: :destroy

    before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      super do
        render json: { user: current_user,
                       token: form_authenticity_token }.to_json and return
      end
    end

    # DELETE /resource/sign_out
    def destroy
      super do
        render json: { success: true }.to_json and return
      end
    end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    end
  end
end
