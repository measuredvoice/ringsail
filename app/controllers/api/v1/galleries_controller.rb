class Api::V1::GalleriesController < Api::ApiController
	def	index	
		@galleries = Gallery.all
		respond_to do |format|
			format.json { render "index" }
			format.xml { render xml: @galleries }
			format.csv { send_data @galleries.to_csv }
			format.xls { send_data @galleries.to_csv(col_sep: "\t")}
		end
	end

	def show
		@gallery = Gallery.find(params[:id])
		respond_to do |format|
			format.json { render "show" }
			format.xml { render xml: @gallery }
			format.csv { send_data @gallery.to_csv }
			format.xls { send_data @gallery.to_csv(col_sep: "\t")}
		end
	end
end