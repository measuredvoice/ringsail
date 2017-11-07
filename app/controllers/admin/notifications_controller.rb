class Admin::NotificationsController < Admin::AdminController
  helper_method :sort_column, :sort_direction
  respond_to :html, :xml, :json
  before_action :set_user
  before_action :set_notification, only: [:show, :destroy]
  before_filter :admin_two_factor, except: [:about, :impersonate, :dashboard]
  before_action :require_admin_or_owner

  # GET /users/1/notifications
  # GET /users/1/notifications.json
  def index
    if(current_user.id == @user.id)
      @user.notifications.update_all(has_read: true)
    end
    @notifications = @user.notifications.all.order(sort_column + " " + sort_direction).page(params[:page]).per(params[:page_size])
  end

  # GET /users/1/nofications/1
  # GET /users/1/nofications/1.json
  def show

  end

  # DELETE /users/1/notificatons/1
  # DELETE /users/1/notificatons/1.json
  def destroy
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # DELETE /users/1/notificatons/destroy_all
  # DELETE /users/1/notificatons/destroy_all.json
  def destroy_all
    @user.notifications.destroy_all
    redirect_to 
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end

 

  def set_notification
    @notification = Notification.find(params[:id])
  end
  
  def sort_column
    Notification.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
