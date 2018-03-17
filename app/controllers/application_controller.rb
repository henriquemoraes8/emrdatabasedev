class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session
  #respond_to :json
  # For now, just to not get errors, cuz when user can not authenticate is showing new.html.erb
  respond_to :html, :json

  Azure.config.storage_account_name = "emergedb"
  Azure.config.storage_access_key = "FZ424WoKBucuSBsO8+G7MYRRtncTqWbZ2Sd7KxmecyQa2Gk+1NkQMi+dILPTCzQECB2sZTZ79Uupy6UXuegt/Q=="
end
