class UsersController < ApplicationController
	#skip_before_action :authorize
	
	def index
		@users = User.order(:name)
	end
	def new
		@user = User.new
	end
	def show
		 @user = User.find(params[:id])
	end
	def edit
		 @user = User.find(params[:id])
	end
	def create

		@user = User.new(user_params)
		respond_to do |format|
			if @user.save
				format.html {redirect_to users_url , notice: "User #{@user.name} was successfully created" }
				format.json { render action: 'show',status: :created, location: @user }
			else
				format.html { render action: 'new' }
				format.json { render json: @user.errors,
				status: :unprocessable_entity }
			end
		end
	end

	def update
		
		@user = User.find(params[:id])
		@new = BCrypt::Password.create(edit_params[:new_password])
        if @user and @user.authenticate(edit_params[:password])
        	
            @user.update(password_digest: @new)
            respond_to do |format|
	            if @user.save
					format.html {redirect_to users_url , notice: "Password changed successfully" }
					format.json { render action: 'show',status: :created, location: @user }
				else
					format.html { render action: 'edit' }
					format.json { render json: @user.errors,
					status: :unprocessable_entity }
				end
         	end
        end
	end

	def destroy
		@user = User.find(params[:id])
	    begin
	      @user.destroy
	      flash[:notice] = "User #{@user.name} deleted"
	    rescue StandardError => e
	      flash[:notice] = e.message
	    end
	      respond_to do |format|
	      format.html { redirect_to users_url }
	      format.json { head :no_content }
    	end
  end

	private
	def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
    def edit_params
      params.require(:user).permit(:name, :password, :new_password)
    end
    
end
