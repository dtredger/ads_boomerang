class AddBeeswaxFieldsToCreative < ActiveRecord::Migration[5.0]
  def change
		change_table :creatives do |t|
			t.integer :beeswax_creative_id
			t.string :beeswax_preview_url
			t.string :beeswax_preview_token
			t.integer :beeswax_creative_asset_id
		end
  end
end
