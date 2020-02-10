# app/controllers/users/omniauth_controller.rb
module Users
  class OmniauthCallbacksController < ApplicationController
    def login_dot_gov
      omniauth_info = request.env['omniauth.auth']['info']
      @user = User.find_by(email: omniauth_info['email'])
      if @user
        @user.update!(user: omniauth_info['uuid'])
        sign_in @user
        redirect_to admin_path

      # Can't find an account, tell user to contact login.gov team
      else
        if(omniauth_info['email'].end_with?(".gov") || omniauth_info['email'].end_with?(".mil"))
          new_user = User.create({
            email: omniauth_info['email'],
            user: omniauth_info['email'],
            first_name: omniauth_info['given_name'],
            last_name: omniauth_info['family_name']
          })
          redirect_to admin_user_path(new_user.id), notice: "You do not currently have an Agency assigned to user account, please update your user profile to manage accounts"
        else
          redirect_to admin_about_path, status: 302, notice: "Your account could not be found.  Please contact the administrators."
        end
      end
    end


    def failure
      redirect_to admin_about_path, status: 302, notice: "Your account could not be found.  Please contact the administrators."
    end
  end
end