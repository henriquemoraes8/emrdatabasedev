class ClinicsController < ApplicationController
  def create
  end

  def login
    #PEGAR LOGIN COM SENHA
    @clinic = Insurance.find_by(:email => params[:clinic][:email].downcase)

    return render :json => { :error => "Clinic does not exist" }, :status => 400 if @clinic.nil?

    render :show, :status => 202
  end

  def records
    user = User.find(params[:user_id])
    @records = user.records
    #IMPLEMENTAR LOGICA SE TIVER PERMISSAO
    return render 'records/index', :status => 202
  end

  def records_by_clinic

  end

  def upload_file

  end

  def search_users_by_clinic

  end

  def search_users

  end
end
