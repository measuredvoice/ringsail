class Admin::EmailMessagesController < Admin::AdminController

	before_filter :require_admin, except: [:new, :create, :show]

	def index
		@emails = EmailMessage.page(params[:page]).per(15)
	end
	
	def new
		@emails = []
		if params[:include_admins]
			admins = User.where("role = ?", User.roles[:admin])
			admins.each do |admin|
				@emails << admin.email
			end
		end
		if params[:param1]
			if !@emails.include? params[:param1]
				@emails << params[:param1]
			end
		end
		if !@emails.include? current_user.email
			@emails << current_user.email
		end
		@email = EmailMessage.new(to: @emails.map(&:to_s).join(', '))
	end

	def show

	end

	def create
		@email = EmailMessage.new(email_message_params)
		@email.user = current_user
		if @email.save
			flash[:notice] = "Email successfully sent!"
			EmailJob.perform_later @email
			render 'sent'
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
