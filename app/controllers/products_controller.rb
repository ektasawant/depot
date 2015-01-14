class ProductsController < ApplicationController
  def index
    @product=Product.all
  end

  def edit
    @product=Product.find(params[:id])
  end

  def show
    @product=Product.find(params[:id])
  end

  def new
    @product=Product.new
  end

  def create
    @product = Product.new(ad_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    @product=Product.find(params[:id])
    @product.update(ad_params)
    redirect_to"/products/#{@product.id}"
  end


    def destroy
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to"/products/"
  end
  #def update
  #  @product=Product.find(params[:id])
   # @product.update_attributes(ad_params)
    #redirect_to "/products/#{@product.id}"
  #end
  
  private
    def ad_params
    params.require(:product).permit(:title,:description,:image_url,:price)
  end
end
