# Preview all emails at http://localhost:3000/rails/mailers/validation_mailer
class ValidationMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    ValidationMailer.validation_email(User.first)
  end
end
