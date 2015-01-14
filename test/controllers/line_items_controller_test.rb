require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
	 test "should create line_item" do 
	 	assert_difference('LineItem.count') do # expected value will be  1 it willchk with next block
	 		post :create, product_id: products(:ruby).id
	 	end
	 	assert_redirected_to cart_path(assigns(:line_item).cart)
	 end
	 test "should update line_item" do
	 	byebug
	 	@line_item = LineItem.create(cart_id:1 , product_id:5)
		patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
		assert_redirected_to line_item_path(assigns(:line_item))
	 end
end
