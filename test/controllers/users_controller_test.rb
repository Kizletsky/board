# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @regular_user = users(:user1)
    @regular_user2 = users(:user2)
    @admin = users(:admin)
  end

  test "don't let regular user get index" do
    # only admin has access to this page
    sign_in @regular_user
    get users_path
    assert_redirected_to root_path
    assert_equal 'You are not an admin !', flash[:alert]
  end

  test 'should show profile to regular_user' do
    sign_in @regular_user
    get user_path(@regular_user)
    assert_response :success
  end

  test 'should not let user change another user profile' do
    sign_in @regular_user
    get edit_user_path(@regular_user2)
    assert_redirected_to root_path
    assert_equal 'You are not an admin !', flash[:alert]
  end

  test 'should let admin change any profile' do
    sign_in @admin
    get edit_user_path(@regular_user)
    assert_response :success

    patch user_path(@regular_user), params: { user: { role: 'admin',
                                                      username: 'updated' } }
    assert_redirected_to user_path(@regular_user)
    assert_equal 'User profile updated', flash[:success]
  end

  test 'should let admin delete any user profile' do
    sign_in @admin
    assert_difference('User.count', -1) do
      delete user_path(@regular_user), xhr: true
    end
  end

  test 'should not let regular user change his role' do
    sign_in @regular_user
    patch user_path(@regular_user), params: { user: { role: 'admin',
                                                      username: 'updated' } }
    assert_redirected_to root_path
    @regular_user.reload
    assert_equal 'user', @regular_user.role
  end
end
