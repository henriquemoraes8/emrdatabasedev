class ApplicationController < ActionController::Base
  #protect_from_forgery with: :null_session
  #respond_to :json
  # For now, just to not get errors, cuz when user can not authenticate is showing new.html.erb
  respond_to :html, :json
end
