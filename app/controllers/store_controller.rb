class StoreController < ApplicationController
  # for getting an object @cart include currentcart
  include CurrentCart
  skip_before_action :authorize
  before_action :set_cart
  def index
    @count = increment_count
  	if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else

      @products = Product.order(:title)
    end
  end

  def increment_count
        if session[:counter].nil?
            session[:counter] = 0
        end
        session[:counter] += 1
    end
end
