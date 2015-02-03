class AddProductPriceToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :price, :decimal 
    	LineItem.all.each do |lineitem|
        	lineitem.update_attribute :price, lineitem.product.price
      	end
  end
end
