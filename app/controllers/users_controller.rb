class UsersController < ApplicationController

  require 'net/http'
  require 'net/https'
  require 'uri'

  before_action :authenticate, except: [:records, :records_by_clinic, :clinics, :requests]
  before_action :authenticate_request, only: [:info_by_request_token, :approve_request, :deny_request, :consent_form]

  def update
    if @user.update_with_password(user_params)
      render 'users/show', :status => 202
    else
      render json: {message: "password not valid"}, :status => 401
    end
  end

  def validate
    user = User.find_by(id: params[:user_id])
    (render json: {message: "user does not exist"}, :status => 404 if user.nil?) && return

    code = rand.to_s[2..7]
    Validation.create(user_id: user.id, code: code)
    uri = URI.parse("https://textbelt.com/text")
    Net::HTTP.post_form(uri, {
        :phone => user.phone,
        :message => "Hello #{user.name}, your verification code is #{code}",
        :key => 'aa16cce9f3352b251c9c0aece4c17b4d645fbc23GxYXeLBAafH4YiQcdGrgixYZY',
    })
    render json: {success: true, message: "success"}, :status => 202
  end

  def verify
    verify_user_with_code(params[:user_id], params[:code])
    render json: {success: true}, :status => 202
  end

  def records
    @records = @user.records
    unless params[:record_types].nil?
      @records = @records.by_types(params[:record_types].split(',').map { |t| t.to_i })
    end
    render 'records/index', :status => 202
  end

  def records_by_clinic
    @records = @user.records.where(:clinic_id => params[:clinic_id])
    unless params[:record_types].nil?
      @records = @records.by_types(params[:record_types].split(',').map { |t| t.to_i })
    end
    render 'records/index', :status => 202
  end

  def clinics
    @clinics = @user.clinics
    render 'clinics/index', :status => 202
  end

  def info_by_request_token
    @user = @request.user
    render 'users/show_limited', :status => 202
  end

  def consent_form
    @user = @request.user
    @address = @user.address
    @is_patient = params[:is_patient] || true
    @legal_name = params[:legal_name]
    @legal_relationship = params[:legal_relation]

    @html_content = render_to_string 'users/consent_form'
    render :json => { :consent_form => @html_content }
    #render 'users/consent_form'
  end

  def approve_request
    @request.status = ShareRequest.statuses[:approved]
    @request.is_patient = params[:is_patient] || true
    @request.legal_rep_name = params[:legal_name]
    @request.legal_rep_relation = params[:legal_relation]

    clinic = @request.clinic
    @request.user.records.map { |r| clinic.records << r }

    @request.save

    render json: {success: true}, :status => 202
  end

  def deny_request
    @request.status = ShareRequest.statuses[:denied]
    @request.save
    render json: {success: true}, :status => 202
  end

  def requests
    @share_requests = @user.share_requests
    render 'share_requests/index', :status => 202
  end

  protected

  def authenticate
    @user = User.find_by_authentication_token(request.headers['X-TOKEN'])
    render json: {message: "user does not exist"}, :status => 401 if @user.nil?
  end

  def authenticate_request
    @request = ShareRequest.find_by(token: params[:request_token])
    render json: {message: "no request found", success: false}, :status => 404 if @request.nil?
  end

  def user_params
    params.require(:user).permit([:name, :last_name, :email, :phone, :social, :birth_date, :password, :password_confirmation, :current_password, address: [:street, :city, :zip, :apt, :state]])
  end

end
