def login_user
  user = create :user
  session[:user_id] = user.id
  user
end
