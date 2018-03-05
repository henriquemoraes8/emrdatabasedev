module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_session
  end

  protected
  def check_session
    if current_clinic
      flash.clear
      redirect_to(new_clinic_session_path) && return
    elsif current_insurance
      flash.clear
      redirect_to(new_insurance_session_path) && return
    elsif current_user
      flash.clear
      redirect_to(login_user_path) && return
    end
  end
end