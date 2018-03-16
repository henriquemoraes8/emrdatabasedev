class InsurancesController < ApplicationController

  #before_action :authenticate_insurance!

  before_action :authenticate

  def authenticate
    @insurance = Insurance.find_by(email: request.headers['X-USER-EMAIL'])
    render json: {success: false}, :status => 401 if @insurance.nil?
  end

  def records
    user = @insurance.users.find(params[:user_id]) # current_insurance.users.find(params[:user_id])
    @records = user.records
    render 'records/index', :status => 202
  end

  def records_by_clinic
    user = @insurance.users.find(params[:user_id]) # current_insurance.users.find(params[:user_id])
    @records = user.records.where(clinic_id: params[:clinic_id])
    render 'records/index', :status => 202
  end

  def search_users
    @users = @insurance.users.search(params[:name], params[:phone], params[:email], params[:social])# current_insurance.users.search(params[:name], params[:phone], params[:email], params[:social])
    render 'users/index', :status => 202
  end

  def user_details
    @user = @insurance.users.find_by(id: params[:user_id])
    (render json: {success: false, message: "user does not belong to insurance"}, :status => 401 && return) if @user.nil?
    render 'users/show_full', :status => 202
  end

end
