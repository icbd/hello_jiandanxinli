require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test "用户登录 密码" do
    get login_path

    tel = '18818818866'
    $redis.set("auth_code:#{tel}", '8866')
    post users_path, params: {
        user: {
            telephone: tel,
            password: 'abc!123',
            auth_code: '8866'
        }
    }

    post login_path, params: {
        session: {
            telephone: tel,
            password: 'abc!123',
        }
    }

    follow_redirect!
    assert_template 'pages/hello'
  end

  test "用户登录 短信" do
    get login_path

    tel = '18818818866'
    $redis.set("auth_code:#{tel}", '8866')
    post users_path, params: {
        user: {
            telephone: tel,
            password: 'abc!123',
            auth_code: '8866'
        }
    }

    post login_path, params: {
        session: {
            telephone: tel,
            auth_code: '8866'
        }
    }

    follow_redirect!
    assert_template 'pages/hello'
  end
end
