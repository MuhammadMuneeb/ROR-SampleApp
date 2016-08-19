require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "Invalid signup information" do
    get edit_signup_path
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

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {
                                           name: "Example user",
                                           email: "user@example.com",
                                           password: "password",
                                         password_confirmation: "password"
                                       }
                                       end
        assert_template 'users/show'
        assert is_logged_in?
  end
end
