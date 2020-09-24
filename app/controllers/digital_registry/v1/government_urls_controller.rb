class DigitalRegistry::V1::GovernmentUrlsController < DigitalRegistry::ApiController


	PAGE_SIZE=25
	DEFAULT_PAGE=1

	def index
    params[:page_size] = params[:page_size] || PAGE_SIZE
		@government_urls = GovernmentUrl.where("url LIKE ? or federal_agency LIKE ? or level_of_government LIKE ? or location LIKE ? or status LIKE ? or note LIKE ? or link LIKE ? or date_added LIKE ?",
     "%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%")

		@government_urls =@government_urls.order(updated_at: :desc).page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		respond_to do |format|
			format.json { render "index" }
		end
	end


	def show
    params[:page_size] = params[:page_size] || PAGE_SIZE
		@government_urls =  GovernmentUrl.where(id: params[:id]).page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		respond_to do |format|
			format.json { render "show" }
		end
	end

end
