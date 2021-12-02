class ChangeIntegerLimitInSaleDetails < ActiveRecord::Migration[6.1]
  def change
    change_column :sale_details, :apn_code, :integer, limit: 8
  end
end
