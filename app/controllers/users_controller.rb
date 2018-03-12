class UsersController < ApplicationController

  #before_action :authenticate_user!
  #
  before_action :authenticate

  def authenticate
    @user = User.find_by(email: request.headers['X-USER-EMAIL'])
    render json: {success: false}, :status => 401 if @user.nil?
  end

  def records
    @records = @user.records #current_user.records
    render 'records/index', :status => 202
  end

  def records_by_clinic
    @records = @user.records.where(:clinic_id => params[:clinic_id]) #current_user.records.where(:clinic_id => params[:clinic_id])
    render 'records/index', :status => 202
  end

  def validate
  end

  def clinics
    @clinics = @user.clinics
    render 'clinics/index', :status => 202
  end

  def approve_request
    request = @user.share_requests.find_by(id: params[:request_id])
    if request.nil?
      render json: {success: false}, :status => 500 && return
    end
    request.status = ShareRequest.statuses[:approved]
    request.save
    render json: {success: true}, :status => 202
  end

  def deny_request
    request = @user.share_requests.find_by(id: params[:request_id])
    if request.nil?
      render json: {success: false}, :status => 500 && return
    end
    request.status = ShareRequest.statuses[:denied]
    request.save
    render json: {success: true}, :status => 202
  end

end
