class CreativesBelongToCampaignNotAdvertiser < ActiveRecord::Migration[5.0]
  def change
		remove_column :creatives, :advertiser_id

		add_column :creatives, :campaign_id, :integer

		add_index :creatives, :campaign_id
  end
end
