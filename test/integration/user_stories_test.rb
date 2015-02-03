require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  fixtures :payments

  test "buying a product" do
  	LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    get "/"
    assert_response :success
    assert_template "index"

    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success

    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    get "/orders/new"
    assert_response :success
    assert_template "new"

    post_via_redirect "/orders",
                      order: { name:     "Dave Thomas",
                               address:  "123 The Street",
                               email:    "dave@example.com",
                               payment_id: 1 }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Dave Thomas",      order.name
    assert_equal "123 The Street",   order.address
    assert_equal "dave@example.com", order.email
    #assert_equal "Check",            order.pay_type
    assert_equal 1,                  order.payment_id

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product


    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Ekta Sawant <ektasawant99@gmail.com>', mail[:from].value
    assert_equal "Pragmatic Store Order Shipped Date Changed", mail.subject
  end


    test "Check Error" do
      get "/carts/n"
      assert_response :redirect
      assert_redirected_to login_url
      mail = ActionMailer::Base.deliveries.last
      assert_equal ["ektasawant99@gmail.com"], mail.to
      assert_equal 'Ekta Sawant <ektasawant99@gmail.com>', mail[:from].value
      assert_equal "Error Occur", mail.subject
    end

    test "Logout user" do
      get "/users/1/edit"
      assert_response :redirect
      #dave = users(:one)
      #post :create, name: dave.name, password: 'abdd'
      assert_redirected_to login_url
    end
end
