# frozen_string_literal: true
module Devise
  class Users::RegistrationsController < Devise::RegistrationsController
    #include Accessible

    before_action :configure_sign_up_params, only: [:create]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      super do |resource|
        unless Clinic.find_by_authentication_token(request.headers['X-TOKEN']).nil?
          forgot_password_flow(resource.email)
        end
        render json: { user: resource }.to_json and return
      end
    end

    def password
      validation = Validation.find_by(code: params[:token])
      (render json: {success: false, message: "invalid token"}, :status => 401 if validation.nil?) && return
      user = validation.user
      unless user.update(password: params[:password], password_confirmation: params[:password_confirmation] || "", status: User.statuses[:active])
        render json: {success: false, message: "password and confirmation do not match"}, :status => 401
        return
      end
      validation.destroy
      render 'users/show', :status => 202
    end

    def forgot_password
      forgot_password_flow(params[:email])
      render json: {success: true}, :status => 202
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

    def forgot_password_flow(email)
      user = User.find_by(email: email)
      validation = Validation.create(user_id: user.id, code: SecureRandom.hex(4))
      ValidationMailer.forgot_password_email(validation).deliver
    end

  end

end

