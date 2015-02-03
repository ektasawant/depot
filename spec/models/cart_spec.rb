require 'rails_helper'
describe Cart do
    describe "Associations" do
         it{ should have_many :line_items }
    end

    describe "#add_product" do
    it "should add product to line_items" do
      #line_item = create :line_item
      cart = create :cart
      product = create :product
      line_item = create :line_item, cart: cart,product: product

      expect{
        cart.add_product(product.id).to change(line_item.quantity, :count).from(1).to(2)}



      # =================
      # order.add_line_items_from_cart(cart)
      # expect(cart.line_items.count).to eq(0)
      # expect(order.line_items.count).to eq(2)

    end
  end
end
