class UsersController < ApplicationController

  before_action :authenticate_user!

  def records
    @records = current_user.records
    render 'records/index', :status => 202
  end

  def records_by_clinic
    @records = current_user.records.where(:clinic_id => params[:clinic_id])
    render 'records/index', :status => 202
  end

  def validate
  end

end
