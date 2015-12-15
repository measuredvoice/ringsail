class Admin::GalleriesController < Admin::AdminController
  helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json, :csv, :xls
  before_action :set_gallery, only: [:show, :edit, :update, :destroy,
    :publish, :archive, :request_archive, :request_publish]
  # GET /gallerys
  # GET /gallerys.json
  def index
    @galleries = Gallery.includes(:official_tags, :agencies).where("draft_id IS NULL").uniq

    num_items = items_per_page_handler
    respond_to do |format|
      format.html { @galleries = [] }
      format.json { render "index" }
      format.csv { send_data @galleries.to_csv }
    end
  end

  def galleries_export
    @galleries = Gallery.where("id IN (?)",params[:ids].split(",")).includes(:official_tags,:users,:agencies)
    respond_to do |format|
      format.csv { send_data @galleries.to_csv }
    end
  end

  # GET /gallerys/1
  # GET /gallerys/1.json
  def show

  end

  # GET /gallerys/new
  def new
    @gallery = Gallery.new
    @gallery.agencies << current_user.agency if current_user.agency
    @gallery.users << current_user
  end

  # GET /gallerys/1/edit
  def edit
    @mobile_apps = MobileApp.all
  end

  # POST /gallerys
  # POST /gallerys.json
  def create
    @gallery = Gallery.new(gallery_params)
    respond_to do |format|
      if @gallery.save
        # @gallery.published!
        @gallery.gallery_items_ol = gallery_params[:gallery_items_ol]
        if @gallery.save
          format.html { redirect_to admin_gallery_path(@gallery), notice: "Gallery was successfully created. Please review and click 'Publish' to publish this record to the API." }
          format.json { render :show, status: :created, location: @gallery }
        else
          format.html { render :new }
          format.json { render json: @gallery.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gallerys/1
  # PATCH/PUT /gallerys/1.json
  def update
    respond_to do |format|
      if @gallery.update(gallery_params)
        # if @gallery.published?
        #   @gallery.published!
        # end
        format.html { redirect_to admin_gallery_path(@gallery), notice: "Gallery was successfully updated. Please review and click 'Publish' to publish this gallery to the API." }
        format.json { render :show, status: :ok, location: admin_gallery_path(@gallery) }
      else
        format.html { render :edit }
        format.json { render json: @gallery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gallerys/1
  # DELETE /gallerys/1.json
  def destroy
    @gallery.destroy
    respond_to do |format|
      format.html { redirect_to gallerys_url, notice: 'Gallery was successfully destroyed.' }
      format.json { head :no_content }
    end
    redirect_to action: :index
  end

  def activities
    @activities = PublicActivity::Activity.where(trackable_type: "Gallery").order("created_at desc").page(params[:page]).per(25)
  end

  def publish
    @gallery.published!
    @gallery.build_notifications(:published)
    redirect_to admin_gallery_path(@gallery), :notice => "Gallery: #{@gallery.name}, is now published. #{view_context.link_to 'Undo', archive_admin_gallery_path(@gallery)}".html_safe
  end

  def archive
    @gallery.archived!
    @gallery.build_notifications(:archived)
    redirect_to admin_gallery_path(@gallery), :notice => "Gallery: #{@gallery.name}, is now archived. #{view_context.link_to 'Undo', publish_admin_gallery_path(@gallery)}".html_safe
  end

  def request_publish
    @gallery.publish_requested!
    @gallery.build_notifications(:publish_requested)
    redirect_to admin_gallery_path(@gallery), :notice => "Gallery: #{@gallery.name}, has a request in with admins to be published."
  end

  def request_archive
    @gallery.archive_requested!
    @gallery.build_notifications(:archive_requested)
    redirect_to admin_gallery_path(@gallery), :notice => "Gallery: #{@gallery.name}, has a request in with admins to be archived."
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:name, :description, :short_description, :long_description, :agency_tokens, :user_tokens, :tag_tokens, :gallery_items_ol)
    end

    def sort_column
      Gallery.column_names.include?(params[:sort]) ? params[:sort] : "galleries.name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def items_per_page_handler
      per_page_count = 25
      if cookies[:per_page_count_galleries]
        per_page_count = cookies[:per_page_count_galleries]
      end
      if params[:per_page]
        per_page_count = params[:per_page]
        cookies[:per_page_count_galleries] = per_page_count
      end
      return per_page_count.to_i
    end
end
