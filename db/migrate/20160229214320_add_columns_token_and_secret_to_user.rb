class AddColumnsTokenAndSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :secret, :string
    add_column :users, :token, :string
    add_column :users, :uid, :string
  end
end
