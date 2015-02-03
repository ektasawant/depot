class SessionsController < ApplicationController
skip_before_action :authorize
  def new
  end

  def create

    if User.count == 0

        @name = params[:name]
        @password = BCrypt::Password.create(params[:password])
        user=User.create(name: @name,password: @password)
        if user.save
          session[:user_id] = user.id
          redirect_to admin_url
        end
    else
        user = User.find_by(name:[params[:name]])
      	if user and user.authenticate(params[:password])
      		session[:user_id] = user.id
      		redirect_to admin_url
      	else
      		redirect_to login_url , alert: "Invalid user/password combination"
      	end
    end
  end
  def destroy
    session[:user_id] = nil
	  redirect_to store_url, notice: "Logged out"
  end
end
