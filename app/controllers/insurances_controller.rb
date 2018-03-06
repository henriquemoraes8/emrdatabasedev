class InsurancesController < ApplicationController

  before_action :authenticate_insurance!

  def records
    user = current_insurance.users.find(params[:user_id])
    @records = user.records
    render 'records/index', :status => 202
  end

  def records_by_clinic
    user = current_insurance.users.find(params[:user_id])
    @records = user.records.where(clinic_id: params[:clinic_id])
    render 'records/index', :status => 202
  end

  def search_users
    @users = current_insurance.users.search(params[:name], params[:phone], params[:email], params[:social])
    render 'users/index', :status => 202
  end

  private def insurance_params
    params.require(:insurance).permit(:name, :email, :phone, address: [:street, :city, :zip, :apt, :state])
  end

end
