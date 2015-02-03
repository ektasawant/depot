class LineItemsController < ApplicationController
	include CurrentCart
	skip_before_action :authorize, only: :create
	before_action :set_cart, only: [:create , :destroy]
	#before_action :set_line_item, only: [:show, :edit, :update, :destroy]
	def create
      product=Product.find(params[:product_id])
	    # @line_item= @cart.line_items.build(product: product)#from set_cart we'l get @cart cart and build is use for building new lineitems for product
	    @line_item = @cart.add_product(product.id) # call from Cart.rb
    	respond_to do |format|
		      if @line_item.save
			        format.html { redirect_to store_url,
					notice: 'Line item was successfully created.' }

					format.js { @current_item = @line_item }
					format.json { render action: 'show',
					status: :created, location: @line_item }
			  else
					format.html { render action: 'new' }
					format.json { render json: @line_item.errors,
					status: :unprocessable_entity }
			  end
        end
        session[:counter] = 0
    end
    def update
	    @line_item = LineItem.find(params[:id])
	    @line_item.update(line_item_params)
	    redirect_to "/line_items/#{@line_item.id}"
    end
    def destroy
      byebug
    	@line_item = LineItem.find(params[:id])
    	#@cart = @line_item.cart
    	if @line_item.quantity > 1
    		@line_item.quantity -= 1
    		#@line_item.update(quantity:@quantity)
    	else
    		#@cart=@line_item.cart
    		@line_item.destroy
    	end

    	respond_to do |format|
		      if @line_item.save
			        format.html { redirect_to store_url,
					notice: 'Line item was successfully deleted.' }
					format.js
          format.json { render action: 'show',
					status: :created, location: @line_item }
			  else
					format.html { render action: 'new' }
					format.json { render json: @line_item.errors,
					status: :unprocessable_entity }
			  end
        end
    end
	private
		def line_item_params
			params.require(:line_item).permit(:product_id)
		end
end
