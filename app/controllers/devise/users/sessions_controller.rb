# frozen_string_literal: true

module Devise
  class Users::SessionsController < Devise::SessionsController
    #include Accessible
    #skip_before_action :check_session, only: :destroy

    #before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    def create
      puts "HEHREH\n\n"
      super
      puts "GOT CURRENT USER #{current_user.id}"
      redirect_to :login_user_path
    end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    # end
  end
end
