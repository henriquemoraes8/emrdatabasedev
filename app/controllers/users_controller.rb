class UsersController < ApplicationController

  before_action :authenticate_user!

  def create
  end

  def login
    #PEGAR INSURANCE COM SENHA
    @user = Insurance.find_by(:email => params[:user][:email].downcase)

    return render :json => { :error => "User does not exist" }, :status => 400 if @user.nil?

    render :show, :status => 202
  end

  def records
  end

  def records_by_clinic
  end

  def validate
  end
end
