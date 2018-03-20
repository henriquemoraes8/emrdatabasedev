class UsersController < ApplicationController

  require 'net/http'
  require 'net/https'
  require 'uri'

  before_action :authenticate, except: [:validate, :verify]

  def authenticate
    @user = User.find_by_authentication_token(request.headers['X-TOKEN'])
    render json: {message: "email does not exist"}, :status => 401 if @user.nil?
  end

  def validate
    user = User.find_by(id: params[:user_id])
    (render json: {message: "user does not exist"}, :status => 404 if user.nil?) && return

    code = rand.to_s[2..7]
    Validation.create(user_id: user.id, code: code)
    uri = URI.parse("https://textbelt.com/text")
    Net::HTTP.post_form(uri, {
        :phone => user.phone_digits,
        :message => "Hello #{user.name}, your verification code is #{code}",
        :key => 'aa16cce9f3352b251c9c0aece4c17b4d645fbc23GxYXeLBAafH4YiQcdGrgixYZY',
    })
    render json: {message: "success"}, :status => 202
  end

  def verify
    validation = Validation.find_by(user_id: params[:user_id])
    if validation.nil?
      (render json: {message: "no code has been set", success: false}, :status => 401) && return
    elsif validation.expiration < DateTime.now
      (render json: {message: "code has expired", success: false}, :status => 401) && return
    elsif validation.code != params[:code]
      (render json: {message: "wrong code", success: false}, :status => 401) && return
    end

    user = User.find_by(id: params[:user_id])
    user.status = User.statuses[:active]
    user.save
    validation.destroy
    render json: {success: true}, :status => 202
  end

  def records
    @records = @user.records
    render 'records/index', :status => 202
  end

  def records_by_clinic
    @records = @user.records.where(:clinic_id => params[:clinic_id])
    render 'records/index', :status => 202
  end

  def clinics
    @clinics = @user.clinics
    render 'clinics/index', :status => 202
  end

  def approve_request
    request = @user.share_requests.find_by(token: params[:request_token])
    if request.nil?
      render json: {message: "no request found", success: false}, :status => 404 && return
    end
    request.status = ShareRequest.statuses[:approved]

    clinic = request.clinic
    @user.records.map { |r| clinic.records << r }

    request.save

    render json: {success: true}, :status => 202
  end

  def deny_request
    request = @user.share_requests.find_by(token: params[:request_token])
    if request.nil?
      render json: {message: "no request found", success: false}, :status => 404 && return
    end
    request.status = ShareRequest.statuses[:denied]
    request.save
    render json: {success: true}, :status => 202
  end

  def requests
    @share_requests = @user.share_requests
    render 'share_requests/index', :status => 202
  end

end
