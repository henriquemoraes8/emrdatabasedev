class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session
  #respond_to :json
  # For now, just to not get errors, cuz when user can not authenticate is showing new.html.erb
  respond_to :html, :json

  Azure.config.storage_account_name = "emergedb"
  Azure.config.storage_access_key = "FZ424WoKBucuSBsO8+G7MYRRtncTqWbZ2Sd7KxmecyQa2Gk+1NkQMi+dILPTCzQECB2sZTZ79Uupy6UXuegt/Q=="

  def request_via_phone(user, clinic)
    share_request = ShareRequest.create(user_id: user.id, clinic_id: clinic.id)
    link = "https://emr-database.herokuapp.com/#/request?request_token=#{share_request.token}"

    uri = URI.parse("https://textbelt.com/text")
    Net::HTTP.post_form(uri, {
        :phone => user.phone,
        :message => "#{clinic.name} has requested access to your medical records. To allow, click on the following link #{link}",
        :key => 'aa16cce9f3352b251c9c0aece4c17b4d645fbc23GxYXeLBAafH4YiQcdGrgixYZY',
    })
    share_request
  end

  def request_via_email(user, clinic)
    share_request = ShareRequest.create(user_id: user.id, clinic_id: clinic.id)
    ValidationMailer.validation_email(share_request).deliver
    share_request
  end

  def verify_user_with_code(user_id, code)
    validation = Validation.find_by(user_id: user_id)
    if validation.nil?
      (render json: {message: "no code has been set", success: false}, :status => 401) && (return false)
    elsif validation.expiration < DateTime.now
      (render json: {message: "code has expired", success: false}, :status => 401) && (return false)
    elsif validation.code != code
      (render json: {message: "wrong code", success: false}, :status => 401) && (return false)
    end

    user = User.find_by(id: user_id)
    user.status = User.statuses[:active]
    user.save
    validation.destroy
    true
  end

end
