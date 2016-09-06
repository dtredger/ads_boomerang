class AddOpenrtbFieldsToCampaignAndAdvertiser < ActiveRecord::Migration[5.0]
  def change
		change_table :campaigns do |t|
			t.string :alternative_id
			t.float :campaign_budget
			t.float :daily_budget
			t.integer :budget_type
			t.integer :revenue_type
			t.float :revenue_amount
			t.integer :pacing

			t.string :notes
			t.boolean :active
		end

		change_table :advertisers do |t|
			t.string :alternative_id

			t.integer :conversion_method_id
			t.string :default_click_url
			t.string :notes
		end
  end
end
