class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :telephone, null: false, comment: "手机号"
      t.string :password_digest, comment: "密码摘要"
      t.string :auth_code, comment: "手机验证码(注册/登录)"

      t.timestamps
    end

    add_index :users, :telephone, unique: true
  end
end
