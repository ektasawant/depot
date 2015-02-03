require 'rails_helper'
describe StoreController do
before{ @user = login_user }
 describe 'GET #index' do
    it "show all products" do
     get :index , :set_locale =>"en"
     expect(response).to redirect_to store_url
    end
    it "renders the :index view" do
      get :index
      expect(assigns(:products).count).to eq(Product.count)
    end
  end
end
