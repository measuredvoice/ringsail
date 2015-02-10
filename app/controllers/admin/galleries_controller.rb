class Admin::GalleriesController < Admin::AdminController
  helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json, :csv, :xls
  before_action :set_gallery, only: [:show, :edit, :update, :destroy, :history,:restore, :publish, :archive]
  # GET /gallerys
  # GET /gallerys.json
  def index
    if current_user.admin?

      @galleries = Gallery.includes(:official_tags, :agencies).where("draft_id IS NULL").uniq
    else
      @galleries = Gallery.joins(:official_tags, :agencies).where("agencies.id = ? AND draft_id IS NULL", current_user.agency.id).uniq
    end
    @galleries = @galleries.order(sort_column + " " +sort_direction).page(params[:page]).per(25)
    respond_to do |format|
      format.html
      format.json { render json: @gallerys }
      format.xml { render xml: @gallerys }
      format.csv { send_data @gallerys.to_csv }
      format.xls { send_data @gallerys.to_csv(col_sep: "\t")}
    end
  end

  # GET /gallerys/1
  # GET /gallerys/1.json
 # def show
  #end

  # GET /gallerys/new
  def new
    @gallery = Gallery.new
    @mobile_apps = MobileApp.all
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

        @gallery.gallery_items_ol = gallery_params[:gallery_items_ol]
        if @gallery.save
          format.html { redirect_to admin_gallery_path(@gallery), notice: 'Gallery was successfully created.' }
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
        format.html { redirect_to admin_gallery_path(@gallery), notice: 'Gallery was successfully updated.' }
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
  def history
    @versions = @gallery.versions.order("created_at desc")
  end

  def restore
    @gallery.versions.find(params[:version_id]).reify.save!
    redirect_to admin_gallery_path(@gallery), :notice => "Undid changes to mobile app."
  end

  def publish
    @gallery.published!
    redirect_to admin_gallery_path(@gallery), :notice => "Gallery: #{@gallery.name}, is now public."
  end

  def archive
    @gallery.archived!
    redirect_to admin_gallery_path(@gallery), :notice => "Gallery: #{@gallery.name}, is now archived."
  end

  

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_gallery
      @gallery = Gallery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gallery_params
      params.require(:gallery).permit(:name, :description, :tag_tokens, :short_description, :long_description, :agency_tokens, :gallery_items_ol)
    end

    def sort_column
      Gallery.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
