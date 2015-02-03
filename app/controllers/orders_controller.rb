class OrdersController < ApplicationController
	include CurrentCart
	before_action :set_cart, only: [:new, :create]
	before_action :set_order, only: [:show, :edit, :update, :destroy]
	skip_before_action :authorize, only: [:new, :create]
	def new
		byebug
		if @cart.line_items.empty?
			redirect_to store_url,notice: 'Your cart is empty'
			return
		else
			@order = Order.new
		end
	end

	def create
		byebug
		@order = Order.new(orders_params)
		@order.add_line_items_from_cart(@cart) #to add lineitems of current cart for placing an order
		@order.ship_date = Time.now
		#Order.order = @order
		$order = @order
		respond_to do |format|
			if @order.save
				Cart.destroy(session[:cart_id])
				session[:cart_id] = nil
				OrderNotifier.received(@order).deliver_now
				OrderNotifier.shipped(@order).deliver_now
				@order.update(ship_date: Time.now + 2.day)
				format.html { redirect_to store_url, notice:I18n.t('.thanks') }
				format.json { render action: 'show', status: :created,location: @order }
			else
				format.html { render action: 'new' }
				format.json { render json: @order.errors,status: :unprocessable_entity }
			end
		end
	end

	# def destroy
	# end

	def shipped_date

	    @order = Order.find(params[:id])
	    @latest_order = Order.order(:updated_at).last
	    if stale?(@latest_order)
	      respond_to do |format|
	        format.atom { render action:'shipped_date'}#look for a template named who_bought.atom.builder
	        format.json { render json: @order.to_json}
	        format.xml { render xml: @order.to_xml}
	      end
	    end
    end

	def orders_params
      params.require(:order).permit(:name,:address,:email,:payment_id,:ship_date)
    end
end
