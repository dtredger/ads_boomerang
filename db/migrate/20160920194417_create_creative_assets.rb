class CreateCreativeAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :creative_assets do |t|
	    t.integer :advertiser_id
	    t.string :name
			t.integer :width
			t.integer :height
			t.string :mounted_asset
			t.integer :beeswax_asset_id
	    t.string :beeswax_alternative_id
	    t.string :notes
	    t.boolean :active
	    t.integer :size_bytes
	    t.string :beeswax_asset_path

	    t.timestamps
    end

		drop_table :creative_line_item_assignments
    drop_table :dripper_messages
    drop_table :dripper_actions

  end
end
