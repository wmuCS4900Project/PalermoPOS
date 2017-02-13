# spec/support/spec_test_helper.rb
module SpecTestHelper   
  def login_admin
    login(:admin)
  end

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    User.find(request.session[:user_id])
  end
end
