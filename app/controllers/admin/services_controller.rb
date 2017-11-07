# == Schema Information
#
# Table name: admin_services
#
#  id                         :integer          not null, primary key
#  handles_regex_eval         :string(255)
#  shortname                  :string(255)
#  longname                   :string(255)
#  display_name_eval          :string(255)
#  account_matchers_eval      :text(65535)
#  service_url_example        :string(255)
#  service_url_canonical_eval :string(255)
#  archived                   :boolean          default(FALSE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Admin::ServicesController < Admin::AdminController
  helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json
  before_action :set_admin_service, only: [:show, :edit, :update, :archive, :restore]

  before_filter :require_admin
  before_filter :admin_two_factor
  # GET /admin/services
  # GET /admin/services.json
  def index
    @admin_services = Admin::Service.all.order(sort_column + " " + sort_direction)
    respond_to do |format|
      format.html { @admin_services = [] }
      format.json { render "index" }
      format.xml { render xml: @admin_services }
    end
  end

  # GET /admin/services/1
  # GET /admin/services/1.json
  def show
  end

  # GET /admin/services/new
  def new
    @admin_service = Admin::Service.new
  end

  # GET /admin/services/1/edit
  def edit
  end

  # POST /admin/services
  # POST /admin/services.json
  def create
    @admin_service = Admin::Service.new(admin_service_regex_params)

    respond_to do |format|
      if @admin_service.save
        format.html { redirect_to @admin_service, notice: 'Service was successfully created.' }
        format.json { render :show, status: :created, location: @admin_service }
      else
        format.html { render :new }
        format.json { render json: @admin_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/services/1
  # PATCH/PUT /admin/services/1.json
  def update
    respond_to do |format|
      if @admin_service.update(admin_service_regex_params)
        format.html { redirect_to @admin_service, notice: 'Service was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_service }
      else
        format.html { render :edit }
        format.json { render json: @admin_service.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @admin_service.update_attribute(:archived, true)
    respond_to do |format|
      format.html { redirect_to admin_service_url(@admin_service), notice: 'Service was successfully archived.' }
      format.json { head :no_content }
    end
  end

  def restore
    @admin_service.update_attribute(:archived, false)
    respond_to do |format|
      format.html { redirect_to admin_service_url(@admin_service), notice: 'Service was successfully restored.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_service
      @admin_service = Admin::Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_service_params
      params.require(:admin_service)
            .permit(:handles_regex_eval, :shortname, :longname,
                    :display_name_eval, :service_url_example,
                    :service_url_canonical_eval, :archived,
                    account_matchers_eval: [
                      :nil, :host, :path, :fragment,
                      :stop_words, conditional: [:if, :then, :else]
                    ])
    end

    def admin_service_regex_params
      admin_service_params.to_hash.tap do |p|
        if p["account_matchers_eval"]
          if conds = p["account_matchers_eval"]["conditional"]
            p["account_matchers_eval"]["conditional"] = conds.reject { |k, v| v.blank? }
          end
          p["account_matchers_eval"] = p["account_matchers_eval"].reject { |k, v| v.blank? }

          if stops = p["account_matchers_eval"]["stop_words"]
            p["account_matchers_eval"]["stop_words"] = stops.split(',')
          end
        end
      end.deep_symbolize_keys
    end

    def sort_column
      Admin::Service.column_names.include?(params[:sort]) ? params[:sort] : "shortname"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
