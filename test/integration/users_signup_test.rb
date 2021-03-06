require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "Invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {
        name: "",
        email: "fop@bar",
        password: "ayy",
        password_confirmation: "lmao"
      }
    end
    assert_template 'users/new'
  end

end
