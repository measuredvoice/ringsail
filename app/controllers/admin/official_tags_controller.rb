class Admin::OfficialTagsController < Admin::AdminController
  respond_to :html, :xml, :json, :csv, :xls

  before_filter :set_tag, only: [:edit, :show, :update]
  # GET /tags
  # GET /tags.json
  def index
    @tags = OfficialTag.all.page(params[:page]).per(params[:page_sze])
  end

  # GET /tags/1
  # GET /tags/1.json

  # GET /tags/new
  def new
    @tag = tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  def show
  end
  

  # POST /tags
  # POST /tags.json
  def create
    @tag = OfficialTag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to admin_tag_path(@tag), notice: 'tag was successfully created.' }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to admin_tag_path(@tag), notice: 'tag was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_tag_path(@tag) }
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag.archived!
    @tag.save!
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'tag was successfully destroyed.' }
      format.json { head :no_content }
    end
    redirect_to action: :index
  end

  def activities
    @activities = PublicActivity::Activity.where(trackable_type: "OfficialTag").order("created_at desc").page(params[:page]).per(25)
  end
  
  def history
    @versions = @tag.versions.order("created_at desc")
  end

  def restore
    @tag.versions.find(params[:version_id]).reify(:has_one=> true, :has_many => true).save!  
    redirect_to admin_tag_path(@tag), :notice => "Changes were reverted."
  end

  def tokeninput
    @tags = OfficialTag.where("shortname LIKE ? OR tag_Text LIKE ?", "%#{params[:q]}%","%#{params[:q]}%").select([:id,:tag_text])
    respond_to do |format|
      format.json { render 'tokeninput'}
    end
  end

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:id, :shortname, :tag_text)
    end

end
