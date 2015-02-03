class ProductsController < ApplicationController
  skip_before_action :authorize #,only: [:who_bought,:index,:show,:create,:edit,:update,:destroy,:new]

   before_filter(only: :who_bought) do |controller|
    check_logged_in unless controller.request.format.html?
   end
  def index
    @cart = Cart.find_by(id: session[:cart_id])
    @products = Product.where(locale:I18n.locale.to_s)
    #@product = Product.all
  end

  def edit
     @product=Product.find(params[:id])
  end

  def show
     @product=Product.find(params[:id])
  end

  def new
    @cart = Cart.find_by(id: session[:cart_id])
    @product=Product.new
  end

  def create
    @cart = Cart.find_by(id: session[:cart_id])
     @product = Product.new(ad_params)
   # locale = params[:locale]
   if ad_params[:locale].to_i == 0
        @product.update(locale: 'es')
    else
        @product.update(locale: 'en')
    end


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
     if ad_params[:locale].to_i == 0
        @product.update(locale: 'es')
    else
        @product.update(locale: 'en')
    end
    @product.update(ad_params)
    #redirect_to"/products/#{@product.id}"
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end


    def destroy
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to"/products"
  end
  #def update
  #  @product=Product.find(params[:id])
   # @product.update_attributes(ad_params)
    #redirect_to "/products/#{@product.id}"
  #end
  def who_bought
    byebug
    @product = Product.find(params[:id])
    @latest_order = @product.orders.order(:updated_at).last
    if stale?(@latest_order)
      respond_to do |format|
        format.atom { render action:'who_bought'}#look for a template named who_bought.atom.builder
        format.html { redirect_to @product}
        format.json { render json: @product.to_json}
        format.xml { render xml: @product.to_xml}
      end
    end

  end

  private
    def ad_params

    params.require(:product).permit(:title,:description,:image_url,:price,:locale)
  end
  def check_logged_in
    authenticate_or_request_with_http_basic("Products") do |username,password|
    username=="admin" && password="ekta"
  end
end
end
