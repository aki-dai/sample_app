require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    
    assert_select 'form[action="/signup"]'
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name: "",
                                          email: "user@invalid",
                                          password:              "foo",
                                          password_confirmation: "bar" 
                                        }
                                }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'

    assert_difference 'User.count' do
      post signup_path, params: { user: { name: "Rails",
                                          email: "user@valid.com",
                                          password:              "qwerty",
                                          password_confirmation: "qwerty" 
                                        }
                                }
    end
    follow_redirect!
    assert_template 'users/show'
    #assert_select 'div.alert-success'
    assert_not flash.empty?
  end
end
