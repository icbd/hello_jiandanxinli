require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(telephone: '18817311035')
  end

  test "手机号唯一" do
    u2 = @user.dup
    assert @user.valid?
    @user.save

    assert_not u2.valid?
  end


  test "非法手机号验证" do
    telephones = ['110', '188-173-110-35', '021-123456', '12345678901234567890', '(021)-1234567', 'usa-1234567']
    telephones.each do |tel|
      @user.telephone = tel
      assert_not @user.valid?, "#{tel} 本应该非法."
    end
  end


  test "合法手机号验证" do
    telephones = ['18817311035']
    telephones.each do |tel|
      @user.telephone = tel
      assert @user.valid?, "#{tel} 本应该合法."
    end
  end


end
