require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should create new tag" do
    sign_in users(:user1)
    post tags_path, params: {name: "sometagname"}, xhr: true
    json_response = JSON.parse(@response.body)
    assert_equal "sometagname", json_response["name"]
  end

end
