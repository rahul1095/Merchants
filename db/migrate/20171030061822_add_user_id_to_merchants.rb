class AddUserIdToMerchants < ActiveRecord::Migration[5.0]
  def change
    add_column :merchants, :user_id, :integer
  end
end
