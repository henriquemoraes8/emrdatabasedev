class ClinicsController < ApplicationController

  before_action :authenticate, except: [:upload_file]

  def authenticate
    @clinic = Clinic.find_by_authentication_token(request.headers['X-TOKEN'])
    render json: {success: false}, :status => 401 if @clinic.nil?
  end

  def records
    @records = @clinic.records
    render 'records/index', :status => 202
  end

  def records_by_clinic
    @records = @clinic.records.where(user_id: params[:user_id], clinic_id: params[:clinic_id])
    render 'records/index', :status => 202
  end

  def access
    @share_request = ShareRequest.create(user_id: params[:user_id], clinic_id: current_clinic.id)
    render 'share_requests/show', :status => 202
  end

  def upload_file
    @user = User.find_by(id: params[:user_id])
    puts @user.name

    #AZURE CONNECTION TO BLOB IMAGES
    blobs = Azure::Blob::BlobService.new
    blobs.set_container_acl("uploads", "container")

    file = params[:file]

    #Create randon
    rand_name=SecureRandom.urlsafe_base64(5)
    thumb_final_name = "#{rand_name}_#{file.original_filename}"

    #Parse thumb and send to azuere
    thumb_content = file.read
    puts file.content_type
    puts thumb_content.size

    blob = blobs.create_block_blob("uploads", "#{thumb_final_name}", thumb_content)

    puts "https://emergedb.blob.core.windows.net/uploads/#{thumb_final_name}"

    render 'users/show_full', :status => 202
  end

  def search_all_users
    @users = User.all
    unless params[:email].blank?
      @user = @users.where("email like ?", params[:email])
    end
    unless params[:social].blank?
      @user = @users.where("social like ?", params[:phone])
    end

    render 'users/index', :status => 202
  end

  def search_users
    @users = @clinic.users.search(params[:name], params[:phone], params[:email], params[:social])
    render 'users/index', :status => 202
  end

  def user_details
    @user = User.find_by(id: params[:user_id]) #@user = @clinic.users.find_by(id: params[:user_id])

    #Rique mesmo eu n tendo acesso a todas as infos dele, precisa trazer o basico no minimo para montar a tela de detalhe conforme wire frame
    #Essa validação cabe para trazer dados como os reports dele para cada clinic, ai sim... teriamos que mover esse metodo pra uma rota comun de usuario
    #Pois as infos basicas e a clinica que ele pertence aparece no wire... ou muda o wire...

    #(render json: {success: false, message: "user does not belong to clinic"}, :status => 406 && return) if @user.nil?
    render 'users/show_full', :status => 202
  end

  def pending
    @share_requests = @clinic.share_requests.where(status: ShareRequest.statuses[:pending]) # current_clinic.share_requests.where(status: ShareRequest.statuses[:pending])
    render 'share_requests/index', :status => 202
  end

  def approved
    @share_requests = @clinic.share_requests.where(status: ShareRequest.statuses[:approved]) #  current_clinic.share_requests.where(status: ShareRequest.statuses[:approved])
    render 'share_requests/index', :status => 202
  end

end
