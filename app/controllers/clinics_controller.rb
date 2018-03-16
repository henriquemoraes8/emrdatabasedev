class ClinicsController < ApplicationController

  #before_action :authenticate_clinic

  before_action :authenticate

  def authenticate
    @clinic = Clinic.find_by(email: request.headers['X-USER-EMAIL'])
    render json: {success: false}, :status => 401 if @clinic.nil?
  end

  def records
    @records = @clinic.records # current_clinic.records
    render 'records/index', :status => 202
  end

  def records_by_clinic
    @records = @clinic.records.where(user_id: params[:user_id], clinic_id: params[:clinic_id])# current_clinic.records.where(user_id: params[:user_id], clinic_id: params[:clinic_id])
    render 'records/index', :status => 202
  end

  def access
    @share_request = ShareRequest.create(user_id: params[:user_id], clinic_id: current_clinic.id)
    render 'share_requests/show', :status => 202
  end

  def upload_file

  end

  def search_all_users
    @users = User.where("email like ?", params[:email])
    render 'users/index', :status => 202
  end

  def search_users
    @users = @clinic.users.search(params[:name], params[:phone], params[:email], params[:social])# current_clinic.users.search(params[:name], params[:phone], params[:email], params[:social])
    render 'users/index', :status => 202
  end

  def pending
    @share_requests = @clinic.share_requests.where(status: ShareRequest.statuses[:pending]) # current_clinic.share_requests.where(status: ShareRequest.statuses[:pending])
    render 'share_requests/index', :status => 202
  end

  def approved
    @share_requests = @clinic.share_requests.where(status: ShareRequest.statuses[:approved]) #  current_clinic.share_requests.where(status: ShareRequest.statuses[:approved])
    render 'share_requests/index', :status => 202
  end

end
