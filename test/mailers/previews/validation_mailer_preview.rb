# Preview all emails at http://localhost:3000/rails/mailers/validation_mailer
class ValidationMailerPreview < ActionMailer::Preview
  def validation_mail_preview
    ValidationMailer.validation_email(User.first)
  end

  def forgot_password_preview
    ValidationMailer.forgot_password_email(Validation.first)
  end

end
