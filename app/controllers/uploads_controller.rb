class UploadsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: [:index, :show, :destroy,:create]
  before_action :set_upload, only: [:show, :edit, :update, :destroy]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)
    respond_to do |format|
      if @upload.save
        #@upload.g_iframe(request.domain)
        @upload.g_iframe("https://still-oasis-17398.herokuapp.com")
        format.html { redirect_to user_path(current_user.id), notice: 'Upload was successfully created.' }
        format.json { render :show, status: :created, location: @upload }
      else
        format.html { render :new }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    cuser = current_user
    if !current_user.present?
      cuser = User.where(token: params[:key]).first
    end  
    if cuser    
      respond_to do |format|
        if @upload.update(upload_params)
          format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
          format.json { render :show, status: :ok, location: @upload }
        else
          format.html { render :edit }
          format.json { render json: @upload.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to{|format| format.json {render json: ["api key missing"]}}
    end        
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  #curl -X PUT -F "upload[course]=999" -F "upload[activity]=770" -F "key=dvVNMMDYbkwiArtDjchjYJDwOSjJuaKhwhiBtvkPIPGoBiBonO" localhost:3000/uploads/3.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload      
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      #require 'pry';binding.pry
      @api_user = User.where(token: params[:key]).first
      if !@api_user.nil?
        params[:upload][:user_id] = @api_user.id
        params[:upload][:info] = @upload.info
      end  
      params.require(:upload).permit(:user_id, :info, :course, :activity, :file)
    end
end
