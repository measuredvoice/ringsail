class Api::V1::MobileAppsController < Api::ApiController
	def index
		@mobile_apps =  MobileApp.all
		respond_to do |format|
			format.json { render "index" }
			format.xml { render xml: @mobile_apps }
			format.csv { send_data @mobile_apps.to_csv }
			format.xls { send_data @mobile_apps.to_csv(col_sep: "\t")}
		end		
	end
	def show
		@mobile_app =  MobileApp.find(params[:id])
		respond_to do |format|
			format.json { render "show" }
			format.xml { render xml: @mobile_app }
			format.csv { send_data @mobile_app.to_csv }
			format.xls { send_data @mobile_app.to_csv(col_sep: "\t")}
		end		
	end
end
