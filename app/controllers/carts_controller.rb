class CartsController < ApplicationController

  #rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart #take rescue.rb file
  skip_before_action :authorize, only: [:create, :update, :destroy]
	def index
		@carts=Cart.all
	end
	def edit
    @cart=Cart.find(params[:id])
	end
	def show
		@cart=Cart.find(params[:id])
	end
	# def create

	#     @cart = Cart.new(cart_params)
 #    	respond_to do |format|
	#       if @cart.save
	#         format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
	#         format.json { render :show, status: :created, location: @cart }
	#       else
	#         format.html { render :new }
	#         format.json { render json: @cart.errors, status: :unprocessable_entity }
	#       end
 #        end
 #    end


 #  def update
 #    @cart = Cart.find(params[:id])
 #    respond_to do |format|
 #      if @cart.update(cart_params)
 #        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
 #        format.json { render :show, status: :ok, location: @cart }
 #      else
 #        format.html { render :edit }
 #        format.json { render json: @cart.errors, status: :unprocessable_entity }
 #      end
 #    end
 #  end

  def destroy
        @cart = Cart.find(params[:id])
        @cart.destroy if @cart.id == session[:cart_id]
        session[:cart_id] = nil
        respond_to do |format|
        format.html { redirect_to store_url }
        format.json { head :no_content }
        end
  end

  private
    def cart_params
      params[:cart]
    end

    def invalid_cart
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid cart' #msg to be store in flash as notice
    end


end
