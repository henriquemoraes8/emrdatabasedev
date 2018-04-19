# frozen_string_literal: true
module Devise
  class Users::RegistrationsController < Devise::RegistrationsController

    before_action :configure_sign_up_params, only: [:create]

    # POST /resource
    def create
      super do |resource|
        render json: { user: resource }.to_json and return
      end
    end

    def password
      validation = Validation.find_by(code: params[:token])
      (render json: {success: false, message: "invalid token"}, :status => 406 if validation.nil?) && return
      user = validation.user
      unless user.update(password: params[:password], password_confirmation: params[:password_confirmation] || "", status: User.statuses[:active])
        render json: {success: false, message: "password and confirmation do not match"}, :status => 406
        return
      end
      validation.destroy
      render 'users/show', :status => 202
    end

    def forgot_password
      forgot_password_flow(params[:email])
      render json: {success: true}, :status => 202
    end

    def email_exists?
      render json: { exists: User.exists?(email: params[:email]) }, :status => 202
    end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :birth_date, :phone, :social,
                                                         address_attributes: [:street, :city, :zip, :apt, :state],
                                                         policy_attributes: [:insurance_id, :policy_number, :policy_group_id]])
    end

  end

end

