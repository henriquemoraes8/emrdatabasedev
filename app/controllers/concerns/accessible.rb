module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_session
  end

  protected
  def check_session
    if !current_clinic.nil?
      flash.clear
      render json: { online_session: 2 }.to_json and return
    elsif !current_insurance.nil?
      flash.clear
      render json: { online_session: 3 }.to_json and return
    elsif !current_user.nil?
      flash.clear
      render json: { online_session: 1 }.to_json and return
    end
  end
end