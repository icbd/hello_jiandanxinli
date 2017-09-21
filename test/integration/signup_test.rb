require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  test "注册用户 合法 有密码" do
    get signup_path

    assert_difference "User.count", 1 do
      tel = '18818818866'
      $redis.set("auth_code:#{tel}", '8866')
      post users_path, params: {
          user: {
              telephone: tel,
              password: "abc!123",
              auth_code: '8866'
          }
      }
    end

    follow_redirect!
    assert_template 'pages/hello'
  end

  test "注册用户 合法 无密码" do
    get signup_path

    assert_difference "User.count", 1 do
      tel = '18818818866'
      $redis.set("auth_code:#{tel}", '8866')
      post users_path, params: {
          user: {
              telephone: tel,
              auth_code: '8866'
          }
      }
    end

    follow_redirect!
    assert_template 'pages/hello'
  end

  test "注册用户 非法" do
    get signup_path

    assert_difference "User.count", 0 do
      tel = '18818818866'
      $redis.set("auth_code:#{tel}", '8866')
      post users_path, params: {
          user: {
              telephone: tel,
              password: "abc!123",
          }
      }
    end
  end
end
