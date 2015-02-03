class OrderNotifier < ApplicationMailer
default from: 'Ekta Sawant <ektasawant99@gmail.com>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
 def received(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Confirmation'
 end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: order.email, subject: 'Pragmatic Store Order Shipped'
  end

  def shipped_date(order)
      @order = order
      mail to: order.email, subject: 'Pragmatic Store Order Shipped Date Changed'
  end
  def error_mail(error)
      @error= error
      mail to: "ektasawant99@gmail.com", subject: 'Error Occur'
  end
end
