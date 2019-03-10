class HomeController < ApplicationController
  def index
  end

  ###Upload.where('description LIKE ?', "%Accelio%").first
  # GET /home/pdf_search.json?q=Accelio
  #curl -X GET -F "key=dvVNMMDYbkwiArtDjchjYJDwOSjJuaKhwhiBtvkPIPGoBiBonO" localhost:3000/home/pdf_search.json?q=Accelio
	def pdf_search
		req = params.permit(:q,:key)
		query = params[:q]
		uploader = User.where(token: req[:key]).first
		respond_to do |format|
			if uploader.nil?
				format.json {render json: ["User with this key was not found."]}
			else
				@results = uploader.uploads.where('description LIKE ?', "%#{query}%")
				if @results.count > 0
					format.json
				else
					format.json {render json: []}
				end	
			end	
		end
	end

end#class end	