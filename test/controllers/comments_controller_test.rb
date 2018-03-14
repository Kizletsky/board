require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @comment1 = comments(:comment1)
    @post1 = posts(:post1)
    sign_in users(:user1)
  end

  test "should let user create a new comment" do
    assert_difference("Comment.count") do
      post post_comments_path(@post1), params: {comment: {body: "some new comment", post_id: @post1.id}}, xhr: true
    end
  end

  test "should let user edit his comment" do
    sign_in users(:user1)
    patch post_comment_path(@post1, @comment1), params: {comment: {body: "updated"}}, xhr: true
    @comment1.reload
    assert_equal "updated", @comment1.body
  end
end
