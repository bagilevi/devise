require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  tests Devise::PasswordsController
  include Devise::TestHelpers

  test "#update passes the request to the model" do
    request.env["devise.mapping"] = Devise.mappings[:user]
    user = create_user

    User.expects(:reset_password_by_token).
      with{|resource_params_arg, options_arg|
        options_arg[:request].is_a? ActionController::TestRequest
      }.
      returns(user)
    put :update,
        :reset_password_token => "anything",
        :user => { :password => "x", :password_confirmation => "x" }
  end
end
