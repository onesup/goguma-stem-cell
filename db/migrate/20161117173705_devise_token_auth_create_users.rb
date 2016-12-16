class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :provider,            :string, :null => false, :default => "email"
    change_column :users, :uid,                 :string, :null => false, :default => ""
    add_column :users, :encrypted_password,     :string, :null => false, :default => ""
    add_column :users, :reset_password_token,   :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :remember_created_at,    :datetime
    add_column :users, :sign_in_count,          :integer, :default => 0, :null => false
    add_column :users, :current_sign_in_at,     :datetime
    add_column :users, :last_sign_in_at,        :datetime
    add_column :users, :current_sign_in_ip,     :string
    add_column :users, :last_sign_in_ip,        :string
    add_column :users, :confirmation_token,     :string
    add_column :users, :confirmed_at,           :datetime
    add_column :users, :confirmation_sent_at,   :datetime
    add_column :users, :unconfirmed_email,      :string
    add_column :users, :nickname,               :string
    add_column :users, :image,                  :string
    add_column :users, :email,                  :string
    add_column :users, :tokens,                 :text
  end
end
