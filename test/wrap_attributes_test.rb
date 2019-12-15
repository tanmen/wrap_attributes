require "abstract_unit"
require "test_helper"

class WrapAttributesTest < ActionController::TestCase
  class UsersController < ActionController::API
    include WrapAttributes::AttributesWrapper
    attr_accessor :last_parameters
    wrap_parameters false

    wrap_attributes :username, posts: [users: [:follower]]

    def test
      self.last_parameters = params.except(:controller, :action).to_unsafe_h
      head :ok
    end
  end

  tests UsersController

  def test_wrap_attributes
    @request.env["CONTENT_TYPE"] = "application/json"
    post :test, params: {"username" => "sikachu", "posts" => [{"users" => [{"follower" => {"id" => 1}}]}]}

    expected = {
      "username" => "sikachu", "username_attributes" => "sikachu",
      "posts" => [{"users" => [{"follower" => {"id" => 1}}]}],
      "posts_attributes" => [{"users_attributes" => [{"follower_attributes" => {"id" => 1}}]}]
    }
    assert_equal expected, @controller.last_parameters
  end
end