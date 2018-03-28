# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post1 = posts(:post1)
    @post2 = posts(:post2)

    @user1 = users(:user1)
    @admin = users(:admin)
  end

  test 'should get index' do
    get posts_path, params: { keywords: '' }
    assert_response :success
  end

  test 'should show post' do
    get post_path(@post1)
    assert_response :success
  end

  test 'should not get new to guest' do
    get new_post_path
    assert_redirected_to new_user_session_path
  end

  test 'should not let guest change post' do
    patch post_path(@post1)
    assert_redirected_to new_user_session_path

    delete post_path(@post1)
    assert_redirected_to new_user_session_path
  end

  test 'should let user create a new post' do
    sign_in @user1
    get new_post_path
    assert_response :success

    post posts_path, params: { post: { title: 'new post title',
                                       body: 'new post body' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h1', 'new post title'
  end

  test 'should let user change his own post' do
    sign_in @user1
    get edit_post_path(@post1)
    assert_response :success

    patch post_path(@post1), params: { post: { title: 'updated' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h1', 'updated'
  end

  test "should not let user change post that don't belongs to him" do
    sign_in @user1
    patch post_path(@post2), params: { post: { title: 'updated' } }
    assert_redirected_to post_path(@post2)
    assert_equal 'You are not the owner of this post', flash[:alert]
  end

  test 'should let admin change any post' do
    sign_in @admin
    get edit_post_path(@post1)
    assert_response :success

    patch post_path(@post1), params: { post: { title: 'updated' } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select 'h1', 'updated'
  end
end
