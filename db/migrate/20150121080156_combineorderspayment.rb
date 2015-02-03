class Combineorderspayment < ActiveRecord::Migration
   def up
    add_column :orders, :payment_id, :integer
    Order.all.each do |order|
    	byebug
        if order.pay_type
            payment = Payment.find_by(payment_name: order.pay_type)
            if payment.id
            	order.update(payment_id: payment.id)
        	end
        end
    end
    remove_column :orders, :pay_type
  end

  def down 
      add_column :order, :pay_type, :string
      remove_column :orders, :payment_id
  end
end
