class AddClickthroughToCampaigns < ActiveRecord::Migration[5.0]
  def change
		add_column :campaigns, :clickthrough_url, :string
  end
end
