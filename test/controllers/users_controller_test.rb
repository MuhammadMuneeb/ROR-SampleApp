require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:michael)
    @other_user = users(:archer)

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    get :update, id: @user, user: {name: @user.name, email: @user.email}
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "When some other user tries to edit other s profile" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "Should redirect if tries to update wrong profile" do
    log_in_as(@other_user)
    patch :update, id: @user, user: {name: @user.name, email: @user.email}
    assert flash.empty?
    assert_redirected_to root_url
  end
end
end
