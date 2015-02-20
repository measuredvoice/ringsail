class Admin::OfficialTagsController < Admin::AdminController
  helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json, :csv, :xls
  before_filter :set_tag, only: [:edit, :show, :update, :history, :restore]

  before_filter :require_admin, except: [:tokeninput]
  # GET /tags
  # GET /tags.json
  def index
    @official_tags = OfficialTag.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:page_sze])
  end

  # GET /tags/1
  # GET /tags/1.json

  # GET /tags/new
  def new
    @official_tag = OfficialTag.new
  end

  # GET /tags/1/edit
  def edit
  end

  def show
  end
  

  # POST /tags
  # POST /tags.json
  def create
    @official_tag = OfficialTag.new(tag_params)

    respond_to do |format|
      if @official_tag.save
        format.html { redirect_to admin_official_tag_path(@official_tag), notice: 'tag was successfully created.' }
        format.json { render :show, status: :created, location: @official_tag }
      else
        format.html { render :new }
        format.json { render json: @official_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @official_tag.update(tag_params)
        format.html { redirect_to admin_official_tag_path(@official_tag), notice: 'tag was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_tag_path(@official_tag) }
      else
        format.html { render :edit }
        format.json { render json: @official_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @official_tag.archived!
    @official_tag.save!
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'tag was successfully destroyed.' }
      format.json { head :no_content }
    end
    redirect_to action: :index
  end

  def history
    @versions = @official_tag.versions
  end

  def restore
    @official_tag.versions.find(params[:version_id]).reify(:has_many => true).save!
    redirect_to admin_official_tag_path(@official_tag), :notice => "changes were reverted."
  end
  
  def tokeninput
    @official_tags = OfficialTag.where("tag_Text LIKE ?", "%#{params[:q]}%").select([:id,:tag_text])
    respond_to do |format|
      format.json { render 'tokeninput'}
    end
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @official_tag = OfficialTag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:official_tag).permit(:id, :tag_text)
    end

    def sort_column
      OfficialTag.column_names.include?(params[:sort]) ? params[:sort] : "tag_text"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

end
