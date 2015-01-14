class LineItemsController < ApplicationController
	include CurrentCart

	before_action :set_cart, only: [:create]
	#before_action :set_line_item, only: [:show, :edit, :update, :destroy]
	def create
		
	    product=Product.find(params[:product_id])
	   # @line_item= @cart.line_items.build(product: product)#from set_cart we'l get @cart cart and build is use for building new lineitems for product
	    @line_item = @cart.add_product(product.id) # call from Cart.rb
    	respond_to do |format|
		      if @line_item.save
			        format.html { redirect_to @cart,
					notice: 'Line item was successfully created.' }
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
   
	private
		def line_item_params
			params.require(:line_item).permit(:product_id)
		end
end
