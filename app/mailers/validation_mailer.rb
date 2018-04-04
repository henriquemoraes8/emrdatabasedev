class ValidationMailer < ApplicationMailer
  default from: 'from@example.com'

  def validation_email(request)
    @user = request.user
    @clinic = request.clinic
    @token = request.token
    mail(to: @user.email, subject: "#{@clinic.name} would like to access your records")
  end

  def consent_email(user)
    @user = user
    @address = user.address
    mail(to: @user.email, subject: "#{@clinic.name} would like to access your records")
  end

end
