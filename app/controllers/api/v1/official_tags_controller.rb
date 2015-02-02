class Api::V1::OfficialTagsController < Api::ApiController
	def index
		@official_tags = OfficialTag.all
		respond_to do |format|
			format.json { render "index" }
			format.xml { render xml: @official_tags }
			format.csv { send_data @official_tags.to_csv } 
			format.xls { send_data @official_tags.to_csv(col_sep: "\t")}
		end
	end

	def show
		@official_tag = OfficialTag.find(params[:id])
		respond_to do |format|
			format.json { render "show" }
			format.xml { render xml: @official_tag }
			format.csv { send_data @official_tag.to_csv }
			format.csv { send_data @official_tag.to_csv(col_sep: "\t")}
		end
	end
end