class Admin::EmailMessagesController < Admin::AdminController

	def index
		@emails = EmailMessage.page(params[:page]).per(15)
	end
	
	def new
		@emails = [current_user.email]
		if params[:param1]
			if !@emails.include? params[:param1]
				@emails << params[:param1]
			end
		end
		if params[:include_admins]
			admins = User.where("role = ?", User.roles[:admin])
			admins.each do |admin|
				@emails << admin.email
			end
		end
		@email = EmailMessage.new(to: @emails.map(&:to_s).join(', '))
	end

	def create
		@email = EmailMessage.new(email_message_params)
		@email.current_user_id = current_user.id
		if @email.save
			flash[:notice] = "Email successfully sent!"
			EmailJob.perform_later @email
			redirect_to admin_users_path
		else
			render "new"
		end
	end	


	private 

		def set_email_message
			@email = EmailMessage.find(params[:id])
		end

		def email_message_params 
			params.require(:email_message).permit(:to, :subject, :body)
		end

end
