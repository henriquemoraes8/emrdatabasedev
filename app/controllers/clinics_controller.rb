class ClinicsController < ApplicationController

  before_action :authenticate_clinic!

  def records
    @records = current_clinic.records
    render 'records/index', :status => 202
  end

  def records_by_clinic
    @records = current_clinic.records.where(user_id: params[:user_id], clinic_id: params[:clinic_id])
    render 'records/index', :status => 202
  end

  def upload_file

  end

  def search_all_users
    @users = User.all
    unless params[:email].blank?
      @user = @users.where("email like ?", params[:email])
    end
    unless params[:phone].blank?
      @user = @users.where("phone like ?", params[:phone])
    end
    render 'users/index', :status => 202
  end

  def search_users
    @users = current_clinic.users.search(params[:name], params[:phone], params[:email], params[:social])
    render 'users/index', :status => 202
  end
end
