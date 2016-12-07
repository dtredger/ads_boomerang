class WebsiteBelongsToAdvertiser < ActiveRecord::Migration[5.0]
  def change
		add_column :websites, :advertiser_id, :integer
  end
end
