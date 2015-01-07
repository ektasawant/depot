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
    @product=Product.create(ad_params)
    @product.save
    redirect_to"/products/"
  end

    def delete
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to"/products/"
  end
  def update
    @product=Product.find(params[:id])
    @product.update_attributes(ad_params)
    redirect_to "/products/#{@product.id}"
  end
  protected
  def ad_params
    params.require(:product).permit(:title,:description,:image_url,:price)
  end
end
