class AddIsConnectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_connect, :boolean
  end
end
