class Admin::UsersController < Admin::AdminController
  helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  before_filter :require_admin, except: [:edit, :update, :tokeninput]
  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(sort_column + " " + sort_direction).page(params[:page]).per(15)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # restrict to admin users or users looking at their own profile
    puts current_user.id
    puts @user.id
    if current_user.id != @user.id
      unless current_user.admin?
        redirect_to admin_dashboards_path, notice: "Hey, thats not your account, check out the dashboard!"
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # restrict to admin users or users looking at their own profile
    if !current_user.admin? || current_user.id != @user.id
      redirect_to admin_dashboards_path, notice: "Hey, thats not your account, check out the dashboard!"
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: admin_user_path(@user) }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def tokeninput
    @users = User.where("first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", "%#{params[:q]}%","%#{params[:q]}%","%#{params[:q]}%")
    respond_to do |format|
      format.json { render 'tokeninput'}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "email"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
