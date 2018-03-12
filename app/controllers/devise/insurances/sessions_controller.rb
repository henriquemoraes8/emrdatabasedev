# frozen_string_literal: true

module Devise
  class Insurances::SessionsController < Devise::SessionsController
    #include Accessible
    #skip_before_action :check_session, only: :destroy

    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      super do
        render json: { insurance: current_insurance,
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
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
