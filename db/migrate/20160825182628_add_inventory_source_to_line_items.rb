class AddInventorySourceToLineItems < ActiveRecord::Migration[5.0]
  def change
		change_table :line_items do |t|
			t.integer :inventory_source, null: false
			t.integer :campaign_id, null: false

		end
  end
end
