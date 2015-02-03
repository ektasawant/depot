require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	test "should create user" do
		assert_difference('User.count') do
			post :create, user: { name: 'sam', password: 'secret',
			password_confirmation: 'secret' }
		end
		assert_redirected_to users_path
	end
	test "should update user" do
		byebug
		@user = User.new(name:"Ekta",password: "aa",password_confirmation:"aa")
		@user.save
		patch :update, id: @user, user: { name: @user.name, password: 'secret',
		password_confirmation: 'secret' }
		assert_redirected_to users_path
	end
end
