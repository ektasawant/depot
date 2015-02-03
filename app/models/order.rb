class Order < ActiveRecord::Base
	#$order
	has_many :line_items , dependent: :destroy
	belongs_to :payment
	#PAYMENT_TYPES = Payment.pluck("payment_name").uniq
	validates :name, :email, :address ,presence: true
	validates :email, uniqueness: true
	#validates :pay_type , inclusion: PAYMENT_TYPES
	after_update :check_ship_date_changed
	def add_line_items_from_cart(cart)
			cart.line_items.each do |item|
			item.cart_id = nil # set cardid null because we r gng to destroy that cart
			line_items << item # add the item itself to the line_items collection for the order
			end
	end

	def check_ship_date_changed
		#order=$order
		if ship_date_changed?
			OrderNotifier.shipped_date(self).deliver_now
		end
	end
end

