class ValidationMailer < ApplicationMailer
  default from: 'emerge@medical.com'

  def validation_email(request)
    @user = request.user
    @clinic = request.clinic
    @token = request.token
    mail(to: @user.email, subject: "#{@clinic.name} would like to access your records")
  end

  def forgot_password_email(validation)
    @user = validation.user
    @token = validation.code
    mail(to: @user.email, subject: "password change")
  end

end
