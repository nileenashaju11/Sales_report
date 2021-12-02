class CreateTransDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :trans_details do |t|
      t.integer :apn_code
      t.float :rrp
      t.float :last_buy_price
      t.string :item_description
      t.string :author
      t.string :product_category
      t.integer :actual_stock_on_hand
      t.date :trans_date
      t.string :trans_time
      t.string :trans_document_number
      t.string :trans_reference_number
      t.integer :trans_quantity
      t.float :trans_total_extax_value
      t.float :trans_total_tax
      t.float :trans_total_discount_given

      t.timestamps
    end
  end
end
