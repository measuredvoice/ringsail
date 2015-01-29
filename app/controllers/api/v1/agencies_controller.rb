class Api::V1::AgenciesController < Api::ApiController
	def index
		@agencies = Agency.all
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