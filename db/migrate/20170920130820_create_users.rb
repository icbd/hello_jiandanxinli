class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :telephone, null: false, comment: "手机号"
      t.string :password_digest, comment: "密码摘要"
      t.string :remember_digest, comment: "记住我摘要"


      t.timestamps
    end

    add_index :users, :telephone, unique: true
  end
end
