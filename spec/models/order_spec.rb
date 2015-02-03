require 'rails_helper'

describe Order do
    describe "Associations" do
         it { should belong_to :payment }
         it { should have_many :line_items}
    end
    it "has a valid factory" do
        expect(create(:order)).to be_valid
    end

    it "is invalid without a name" do
        expect(build(:order, name: nil)).to be_invalid
    end

    it "is invalid without an email" do
        create(:order, email:'ekta@gmail.com')
        expect(build(:order, email: 'ekta@gmail.com')).to be_invalid
    end

    it "is invalid without an address" do
        expect(build(:order, address: nil)).to be_invalid
    end


    describe "#add_line_items_from_cart" do
    it "should move line_items from cart to order" do
      order = create :order
      cart  = create :cart
      line_items = create_list :line_item, 2, cart: cart

      expect{
        order.add_line_items_from_cart(cart)
      }.to change(order.line_items, :count).from(0).to(2)

      expect(cart.line_items.count).to eq(0)

      # =================
      # order.add_line_items_from_cart(cart)
      # expect(cart.line_items.count).to eq(0)
      # expect(order.line_items.count).to eq(2)

    end
  end

  describe "#check_ship_date_changed" do
    it "should send a mail while shipdate is changed" do
      #cart = create :cart
      order = create :order
      order.update_attribute :ship_date ,Time.now
      expect(order).to receive(:check_ship_date_changed)
      order.run_callbacks(:update)
    end
  end

end
