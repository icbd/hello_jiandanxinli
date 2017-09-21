class User < ApplicationRecord
  attr_accessor :password
  attr_accessor :auth_code
  attr_accessor :remember_token

  validates :telephone, presence: true, uniqueness: true,
            format: {with: /\A1[0-9]{10}\z/, message: "Please check phone number format."}

  before_create :password_digest_init

  def update_auth_code(code)
    if get_auth_code
      # wait for ready
      false
    else
      # 'OK'
      $redis.setex(r_key_auth_code, 300, code)
    end
  end

  def get_auth_code
    code = $redis.get r_key_auth_code
  end


  def password_digest_init
    self.password_digest = calc_hash(password) unless password.blank?
  end


  # todo 入库手动验证 or 自动验证手动跳过 ?
  # # before_validation :check_auth_code, on: :create
  def check_auth_code
    return false if auth_code.empty?
    
    if auth_code != get_auth_code.to_s
      errors.add(:auth_code, "auth code error.")
      false
    else
      true
    end
  end


  # redis key for auth_code
  # String
  def r_key_auth_code
    "auth_code:#{telephone}"
  end


  def remember
    self.remember_token = generate_token
    update_attribute(:remember_digest, calc_hash(self.remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
