#spec/models/product_spec.rb

require 'rails_helper' # use instead of spec_helper

describe Product do
  describe "Associations" do
         it { should have_many :line_items }
         it { should have_many :orders}
  end
	it "has a valid factory" do
		expect(create(:product)).to be_valid #crate a valid product by using product fixture
	end
	it "is invalid without title" do
		expect(build(:product,title: nil)).to be_invalid
	end
	it "is invalid without description" do
		expect(build(:product,description: nil)).to be_invalid
	end
	it "is invalid without image_url" do
		expect(build(:product,image_url: nil)).to be_invalid
	end
	it "has a unique title" do
		create(:product,title:"laptop dell")
		expect(build(:product,title:"laptop dell")).to be_invalid
	end
  it "has minimum 10 character title" do
    a = create(:product, title: "laptop dell")
    expect(a.title.length).to be >= 10
  end
  describe "#latest" do
    it "should show latest product" do
      product = create :product
      product1 = create :product
      product.update_attribute :price, 50
      expect(Product.latest).to eq(product)
    end
  end
  describe "#ensure_not_referenced_by_any_line_item" do
    it "should not prsent in line item while destroy product" do
      #cart = create :cart
      product = create :product
      line_item = create :line_item
      expect(product).to receive(:ensure_not_referenced_by_any_line_item)
      product.run_callbacks(:destroy)
    end
  end
  describe "#add product" do
    it "should add line_item for given product" do
      cart = create :cart
      product = create :product
      expect(cart.add_product(product.id)).to be_an_instance_of(LineItem)
    end

    it "should add line_item for given product" do
      cart = create :cart
      product = create :product
      line_item = create :line_item, cart: cart, product: product
      current_line_item = cart.add_product(product.id)
      expect(current_line_item.quantity).to eq(2)
    end
  end


end

#end
