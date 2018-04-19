class InsurancesController < ApplicationController

  before_action :authenticate, except: [:index]

  def index
    @insurances = Insurance.all
    render 'insurances/index_limited', :status => 202
  end

  def update
    if @insurance.update_with_password(insurance_params)
      render 'insurances/show', :status => 202
    else
      render json: {message: "password not valid"}, :status => 401
    end
  end

  def records
    user = @insurance.users.find(params[:user_id])
    @records = user.records
    unless params[:record_types].nil?
      @records = @records.by_types(params[:record_types].split(',').map { |t| t.to_i })
    end
    render 'records/index', :status => 202
  end

  def records_by_clinic
    user = @insurance.users.find(params[:user_id])
    @records = user.records.where(clinic_id: params[:clinic_id])
    unless params[:record_types].nil?
      @records = @records.by_types(params[:record_types].split(',').map { |t| t.to_i })
    end
    render 'records/index', :status => 202
  end

  def search_users
    @users = @insurance.users.search(params[:name], params[:phone], params[:email], params[:social])
    render 'users/index', :status => 202
  end

  def user_details
    @user = @insurance.users.find_by(id: params[:user_id])
    (render json: {success: false, message: "user does not belong to insurance"}, :status => 401 && return) if @user.nil?
    render 'users/show_full', :status => 202
  end

  protected

  def authenticate
    @insurance = Insurance.find_by_authentication_token(request.headers['X-TOKEN']) #Insurance.find_by_email("miami@prog.com")#
    render json: {success: false}, :status => 401 if @insurance.nil?
  end

  def insurance_params
    params.require(:insurance).permit([:name, :phone, :email, :password, :password_confirmation, :current_password, address: [:street, :city, :zip, :apt, :state]])
  end

end
