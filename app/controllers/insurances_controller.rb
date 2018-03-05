class InsurancesController < ApplicationController

  before_action :authenticate_insurance!

  def create
    @insurance = Insurance.new(insurance_params)

    return render :json => { :error => "Insurance already exists" }, :status => 401 unless @insurance.save

    render :show, :status => 202
  end

  def login
    #PEGAR INSURANCE COM SENHA
    @insurance = Insurance.find_by(:email => params[:insurance][:email].downcase)

    return render :json => { :error => "Insurance does not exist" }, :status => 400 if @insurance.nil?

    render :show, :status => 202
  end

  def records
    user = User.find(params[:user_id])
    @records = user.records
    #IMPLEMENTAR LOGICA SE FOR CLINICA LOGADA
    render 'records/index', :status => 202
  end

  def records_by_clinic
  end

  def search_users
  end

  private def insurance_params
    params.require(:insurance).permit(:name, :email, :phone, address: [:street, :city, :zip, :apt, :state])
  end

end
