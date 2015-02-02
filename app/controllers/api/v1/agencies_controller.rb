class Api::V1::AgenciesController < Api::ApiController
	swagger_controller :agencies, "Government Agencies"

	swagger_api :index do
		summary "Fetches all agencies"
    notes "This lists all active agencies.  It accepts parameters to perform basic search."
    param :query, :q, :string, :optional, "String to compare to the name & acronym of the agencies."
    param :query, :page_size, :integer, :optional, "Number of results per page"
    param :query, :page, :integer, :optional, "Page number"
    response :unauthorized
    response :not_acceptable, "The request you made is not acceptable"
    response :requested_range_not_satisfiable
	end

	PAGE_SIZE=25
	DEFAULT_PAGE=1
	def index
		if params[:q]
			@agencies = Agency.where("name LIKE ? or shortname LIKE ?", 
				"%#{params[:q]}%", "%#{params[:q]}%").page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		else
			@agencies = Agency.all.page(params[:page] || DEFAULT_PAGE).per(params[:page_size] || PAGE_SIZE)
		end
		respond_to do |format|
			format.json { render "index"}
			format.xml { render xml: @agencies }
			format.csv { send_data @agencies.to_csv }
			format.xls { send_data @agencies.to_csv(col_sep: "\t")}
		end
	end

	def show
		@agency = Agency.find(params[:id])
		respond_to do |format|
			format.json { render "show"}
			format.xml { render xml: @agency }
			format.csv { send_data @agency.to_csv }
			format.xls { send_data @agency.to_csv(col_sep: "\t")}
		end
	end
end