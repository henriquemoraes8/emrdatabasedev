class ClinicsController < ApplicationController

  require 'net/http'
  require 'net/https'
  require 'uri'

  before_action :authenticate, except: [:upload_file]

  def update
    if @clinic.update_with_password(clinic_params)
      render 'clinics/show', :status => 202
    else
      render json: {message: "password not valid"}, :status => 401
    end
  end

  def records
    @records = @clinic.records
    unless params[:record_types].nil?
      @records = @records.by_types(params[:record_types].split(',').map { |t| t.to_i })
    end
    render 'records/index', :status => 202
  end

  def records_by_clinic
    @records = Record.where(user_id: params[:user_id], clinic_id: params[:clinic_id])
    unless params[:record_types].nil?
      @records = @records.by_types(params[:record_types].split(',').map { |t| t.to_i })
    end
    render 'records/index', :status => 202
  end

  def verify_user_and_email
    unless verify_user_with_code(params[:user_id], params[:code])
      return
    end
    access_email
  end

  def access_email
    @share_request = request_via_email(User.find(params[:user_id]), @clinic)
    render 'share_requests/show', :status => 202
  end

  def verify_user_and_message
    unless verify_user_with_code(params[:user_id], params[:code])
      return
    end
    access_phone
  end

  def access_phone
    @share_request = request_via_phone(User.find(params[:user_id]), @clinic)
    render 'share_requests/show', :status => 202
  end

  def add_insurance_to_user
    user = User.find(params[:user_id])
    user.insurance_unique_id = params[:insurance_unique_id]
    user.insurance_id = params[:insurance_id]
    user.save!
    render json: {success: true}, :status => 202
  end

  def upload_file

    #try auth clinic, Henrique como a frame do angular de upload n deixar eu colocar header estou passando o token por parametro
    @clinic = Clinic.find_by_authentication_token(params[:clinic_token])
    render json: {success: false, message: "clinic not valid"}, :status => 406 if @clinic.nil?

    #try upload to user
    @user = @clinic.users.find_by(id: params[:user_id])
    render json: {success: false, message: "user not validated on clinic"}, :status => 406 if @user.nil?
    render json: {success: false, message: "missing record types"}, :status => 406 if params[:record_types].nil?

    #AZURE CONNECTION TO BLOB IMAGES
    blobs = Azure::Blob::BlobService.new
    blobs.set_container_acl("uploads", "container")

    file = params[:file]

    #Create randon
    rand_name = SecureRandom.urlsafe_base64(5)
    thumb_final_name = "#{rand_name}_#{file.original_filename}"

    #Parse thumb and send to azuere
    thumb_content = file.read
    puts file.content_type
    puts thumb_content.size

    blob = blobs.create_block_blob("uploads", "#{thumb_final_name}", thumb_content)

    puts "https://emergedb.blob.core.windows.net/uploads/#{thumb_final_name}"

    #Path do arquivo feito upload = "https://emergedb.blob.core.windows.net/uploads/#{thumb_final_name}"
    @record = Record.create(user_id: @user.id, clinic_id: @clinic.id, name: params[:name], url: thumb_final_name, mime_type: "#{file.content_type}", file_size: file.size)
    params[:record_types].split(',').each do |t|
      @record.record_types << RecordType.find(t.to_i)
    end

    approved_clinics = @user.clinics - [@clinic]
    approved_clinics.map { |c| c.records << @record }

    render 'records/show', :status => 202
  end

  def search_all_users

    phone = params[:phone] || ""
    phone = phone.scan(/\d/).join('')

    @user = User.find_by('lower(name) = lower(?) AND lower(last_name) = lower(?) AND phone = ? AND birth_date = ?', params[:name], params[:last_name], phone, params[:birth_date].to_date)

    if @user.nil?
      render json: {}, :status => 202
      return
    end

    render 'users/show', :status => 202
  end

  def search_users
    @users = @clinic.users.search(params[:name], params[:phone], params[:email])
    render 'users/index', :status => 202
  end

  def user_details
    @user = User.find_by(id: params[:user_id])

    (render json: {success: false, message: "user does not exist"}, :status => 406 && return) if @user.nil?

    if @clinic.users.include?(@user)
      render 'users/show_full', :status => 202
    else
      render 'users/show_limited', :status => 202
    end
  end

  def pending
    @share_requests = @clinic.share_requests.where(status: ShareRequest.statuses[:pending])
    render 'share_requests/index', :status => 202
  end

  def approved
    @share_requests = @clinic.share_requests.where(status: ShareRequest.statuses[:approved])
    render 'share_requests/index', :status => 202
  end

  protected

  def authenticate
    @clinic = Clinic.find_by_authentication_token(request.headers['X-TOKEN'])#Clinic.find_by_email('miami@cardiology.com')
    render json: {success: false}, :status => 401 if @clinic.nil?
  end

  def clinic_params
    params.require(:clinic).permit([:name, :phone, :email, :password, :password_confirmation, :current_password, address: [:street, :city, :zip, :apt, :state]])
  end

end
