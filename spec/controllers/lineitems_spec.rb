require 'rails_helper'
describe LineItemsController do
before { @user = login_user }

  describe 'POST #create' do
     before do
          @product = create :product
          #@cart = create :cart
         # @line_item = @cart.add_product(@product.id) # call from Cart.rb
      end
     context "with valid attributes" do
       it "saves new line_item in the database" do
           expect{
           #post :create  ,line_item: attributes_for(:line_item)
           post :create, :product_id => @product.id
         }.to change(LineItem,:count).by(1)
       end
       it "renders to index page" do
         post :create ,:product_id => @product.id
         expect(response).to redirect_to store_url
       end
    end

 end



   describe 'DELETE #destroy' do
      before(:each) do
           @line_item = create :line_item,quantity:2
           #@line_item.quantity = 2
           #@line_item.save

      end
      it "delete the line_item from database" do
        expect{
          delete :destroy, id: @line_item
          @line_item.reload
          }.to change(@line_item,:quantity).to eq(1)
      end
      it "redirects to index page" do
        delete :destroy , id: @line_item
        expect(response).to redirect_to store_url
      end
   end


end
