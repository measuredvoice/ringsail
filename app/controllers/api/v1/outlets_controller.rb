class Api::V1::OutletsController < Api::ApiController

  def index
    @outlets = Outlet.all
    respond_to do |format|
      format.json { render "index" }
      format.xml { render xml: @outlets }
      format.csv { send_data @outlets.to_csv }
      format.xls { send_data @outlets.to_csv(col_sep: "\t")}
    end
  end

  def show
    @outlet = Outlet.find(params[:id])
     respond_to do |format|
      format.json { render "show" }
      format.xml { render xml: @outlet }
      format.csv { send_data @outlet.to_csv }
      format.xls { send_data @outlet.to_csv(col_sep: "\t")}
    end
  end
end
