class AddBeeswaxIdsToCampaignAndAdvertiser < ActiveRecord::Migration[5.0]
  def change
	  change_table :campaigns do |t|
		  t.integer :beeswax_id
	  end

	  change_table :advertisers do |t|
		  t.integer :beeswax_id
	  end
  end
end